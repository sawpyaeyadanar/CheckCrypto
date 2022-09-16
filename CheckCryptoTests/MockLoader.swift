//
//  MockLoader.swift
//  CheckCryptoTests
//
//  Created by sawpyae on 9/15/22.
//

import Foundation
import RxSwift
import ObjectMapper
@testable import CheckCrypto

struct MockLoader {

    static func load<T:Mappable>(type: T.Type, file: String) -> Observable<T> {
        return Observable.create { observable in
            if let path = Bundle.main.path(forResource: file, ofType: ""), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                    let user = Mapper<T>().map(JSONString: json as! String)
                    guard let response = user else {
                        observable.onError(CustomError.DecodingError)
                        return Disposables.create()
                    }
                    observable.onNext(response)
                    observable.onCompleted()
                } catch  {
                    observable.onError(NSError(domain: "100", code: 405))
                }
                return Disposables.create()
            }
            return Disposables.create()
        }
    }

}
