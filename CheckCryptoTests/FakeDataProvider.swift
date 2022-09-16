//
//  FakeDataProvider.swift
//  CheckCryptoTests
//
//  Created by sawpyae on 9/15/22.
//

import UIKit
import RxSwift

@testable import CheckCrypto

class FakeDataProvider: CommonService {
       override func fetchCurrency() -> Observable<[CurrencyData]> {

        return  MockLoader.load(type: ResponseData.self, file: "CurrencyList").map { $0.bpi }.map { element -> [CurrencyData] in
            var currAry = [CurrencyData]()
            if let usd = element?.USD {
                currAry.append(usd)
            }
            if let gbp = element?.GBP {
                currAry.append(gbp)
            }
            if let eur = element?.EUR {
                currAry.append(eur)
            }
            return currAry
        }
    }

}

