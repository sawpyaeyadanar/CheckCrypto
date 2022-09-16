//
//  NetworkManager.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/9/22.
//

import Foundation
import RxSwift
import ObjectMapper
class NetWorkManager {

    func fetchData ( url: URL ) -> Observable<Dictionary<String,AnyObject>>  {
        return Observable.create { observable in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return observable.onError(CustomError.DataNotFound) }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                    if let responseData = json as? [String : AnyObject] {
                                observable.onNext(responseData)
                                observable.onCompleted()
                    }else{
                        observable.onError(CustomError.DecodingError)
                    }
                } catch  {
                    observable.onError(CustomError.DecodingError)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
