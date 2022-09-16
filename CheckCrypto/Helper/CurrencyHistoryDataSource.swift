//
//  IntermediateDataSource.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/14/22.
//

import RxDataSources
import UIKit
struct TableViewItem {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

struct TableViewSection {
    let items: [CurrencyData]
    let header: String
    
    init(items: [CurrencyData], header: String) {
        self.items = items
        self.header = header
    }
}

extension TableViewSection: SectionModelType {

    typealias Item = CurrencyData
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct CurrencyHistoryDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<TableViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> CryptoTableViewCell in

            let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! CryptoTableViewCell
            cell.configure(data: item)
            return cell
        }, titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
        })
    }
}
