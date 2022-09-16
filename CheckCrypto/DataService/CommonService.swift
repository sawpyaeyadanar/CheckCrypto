//
//  CommonService.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/9/22.
//

import Foundation
import RxSwift
import ObjectMapper
enum CustomError: Error {
    case DecodingError
    case URLNotFound
    case DataNotFound
}

class CommonService {
     let bag = DisposeBag()
   
    func fetchCurrency() -> Observable<[CurrencyData]> {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return Observable.empty()}
        return NetWorkManager().fetchData(url: url).map { dict -> [CurrencyData] in
            if let element =  Mapper<ResponseData>().map(JSON: dict)?.bpi {
                var currAry = [CurrencyData]()
                if let usd = element.USD {
                    currAry.append(usd)
                }
                if let gbp = element.GBP {
                    currAry.append(gbp)
                }
                if let eur = element.EUR {
                    currAry.append(eur)
                }
                return currAry
            }else{
                return [CurrencyData]()
            }
        }
    }
}
