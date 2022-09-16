//
//  CurrencyHistoryVC.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/14/22.
//

import Foundation
import RxDataSources
import RxSwift
import UIKit
class CurrencyHistoryVC: UIViewController {
    @IBOutlet weak var historytblView: UITableView!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        historytblView.estimatedRowHeight = 100
        historytblView.register(UINib(nibName: "CryptoTableViewCell", bundle: nil), forCellReuseIdentifier: "list")
        bindTableView()
        viewModel.getCurrencyData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = CurrencyHistoryVM()

}

// MARK: - Binding
extension CurrencyHistoryVC {
    private func bindTableView() {
        viewModel.items
            .bind(to: historytblView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
}

