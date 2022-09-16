//
//  CryptoCurrencyVC.swift
//  Ctrypto
//
//  Created by sawpyae on 9/9/22.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
class CryptoCurrencyVC: UIViewController, UIScrollViewDelegate {
    let vm = CryptoCurrencyVM()
    private let bag = DisposeBag()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var currencytblView: UITableView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencytblView.estimatedRowHeight = 100
        currencytblView.register(UINib(nibName: "CryptoTableViewCell", bundle: nil), forCellReuseIdentifier: "list")
        debugPrint(Realm.Configuration.defaultConfiguration.fileURL)

        setupTime()
        vm.saveCurrencyData()
        vm.getCurrencyData()
        vm.fetchData()

        vm.showLoading.asObservable()
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isHidden)
            .disposed(by: bag)

        vm.currencyLists
            .observe(on: MainScheduler.instance)
            .map { (items) -> [CurrencyData] in
                return  items.sorted { $0.currencyname ?? "" > $1.currencyname ?? "" }
            }
            .bind(to: self.currencytblView.rx.items(cellIdentifier: "list",cellType: CryptoTableViewCell.self)) { index,vm, cell in 
                cell.configure(data: vm)
                self.setupTime()
            }.disposed(by: bag)

        historyBtn.rx.tap
            .subscribe(onNext: {
                self.clickHistory()
            })
            .disposed(by: bag)
    }

    func clickHistory(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrencyHistoryVC") as? CurrencyHistoryVC {
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }

    func setupTime() {
        self.dateLbl.text = self.getCurrentDateTime(date: true)
        self.timeLbl.text = self.getCurrentDateTime()
    }

    func getCurrentDateTime(date: Bool = false) -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        if date {
            formatter.dateStyle = .medium
        }else{
            formatter.timeStyle = .medium
        }
        return formatter.string(from: currentDateTime)
    }

    // - MARK: - Additional

    /**
     Writing generate program of Fibonacci’s numbers (0, 1, 1, 2, 3, 5, 8, 13, ...)
     */

    func getFibonanci(number: Int) {
        var fiboAry = [0,1]
        (2...number).forEach { i in
            fiboAry.append(fiboAry[ i - 1 ] &+ fiboAry[ i - 2 ])
            print(fiboAry)
        }
    }

    /**
     Writing generate program of prime numbers (2, 3, 5, 7, 11, 13, 17, 19, ...)
     */

    func getPrimeNumber( n: Int) -> [Int] {
        var primeAry = [Int](2 ..< n)
        for i in 0..<n - 2 {
            let prime = primeAry[i]
            guard prime > 0 else { continue }
            for multiple in stride(from: 2 * prime - 2, to: n - 2, by: prime){
                primeAry[multiple] = 0
            }
        }
        return primeAry.filter{ $0 > 0 }

    }


    /**
     Writing code to filter an array from an array of two numbers, leaving only the
     members of the first array left in the second array, without using existing functions such as map, filter, contain, etc.
     */
    func filterArray() {
        let intAry1 = [3,5]
        var intAry2 = [3,7,5,6,5]
        var filterAry = [Int]()
        for x in intAry1 {
            for y in intAry2 {
                if (y == x) {
                    filterAry.append(y)
                }
            }
        }
        intAry2 = filterAry
        print(intAry2)
    }
}


