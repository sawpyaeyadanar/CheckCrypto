//
//  CheckCryptoTests.swift
//  CheckCryptoTests
//
//  Created by sawpyae on 9/15/22.
//

import XCTest
import RxSwift
@testable import CheckCrypto

class CheckCryptoTests: XCTestCase {
    var bag: DisposeBag!
     var listVM: CryptoCurrencyVM!
    var service: CommonService!

    override  func setUp() {
        listVM = CryptoCurrencyVM()
        bag = DisposeBag()
        service = CommonService()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func test_CurrencyList() {
        FakeDataProvider().fetchCurrency().asObservable()
            .subscribe { ary in
                XCTAssertNotNil(ary, " Currency List Not Null")
            }.disposed(by: bag)
    }

}

