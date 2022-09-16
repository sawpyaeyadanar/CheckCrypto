//
//  CurrencyHistoryVM.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/14/22.
//

import RxSwift
import Foundation
struct CurrencyHistoryVM {
    private let bag = DisposeBag()
    var items = BehaviorSubject<[TableViewSection]>(value: [
        TableViewSection(items: [CurrencyData(),CurrencyData()], header: "")
    ])
    let dataSource = CurrencyHistoryDataSource.dataSource()

    func getCurrencyData() {
        DataBaseHandler().getCurrencyData()
            .map { currenyDataAry in
                return Dictionary(grouping: currenyDataAry) {
                    self.convertTimeFormat(data: $0)
                }.map { (header,value) in
                        return TableViewSection(items: value, header: header)
                    }
            }.bind(to: items)
            .disposed(by: bag)
    }

    func convertTimeFormat(data: CurrencyData) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MM yyyy - hh:mm:ss a"//"EE" to get short style
        let mydt = dateFormatter.string(from: data.time).capitalized
        return mydt
    }
}
