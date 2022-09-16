//
//  CryptoCurrencyVM.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/9/22.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import RealmSwift


class CryptoCurrencyVM {

    private let bag = DisposeBag()
    let willEnterForegroundNoti = NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
    let didEnterBackgroundNoti = NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)

    let currencyLists = BehaviorRelay(value: [CurrencyData]())
    let showLoading = BehaviorRelay<Bool>(value: true)

    func fetchData() {
        willEnterForegroundNoti
            .debug()
            .map { _ in () }
            .startWith(())
            .flatMap { _ in
                // create an interval timer which stops emitting when the app goes to the background
                return Observable<Int>.interval(.seconds(60), scheduler: MainScheduler.instance)
                    .take(until: self.didEnterBackgroundNoti)
            }
            .flatMapLatest { _ in
                return CommonService().fetchCurrency()
            }
            .bind(to: currencyLists)
            .disposed(by: bag)

        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification).subscribe { _ in
            if let lastOpenDate = UserDefaults.standard.object(forKey: "currentTime") as? Date {
                let diffComponents = Calendar.current.dateComponents([.hour], from: lastOpenDate, to: Date())
                if let hours = diffComponents.hour, hours > 24 {
                    self.deleteAllCurrencyData()
                }
            }
        }.disposed(by: bag)

        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).subscribe { _ in
            UserDefaults.standard.set(Date(), forKey: "currentTime")
        }.disposed(by: bag)


    }

    func getCurrencyData() {
        if Reachability.isConnectedToNetwork() {
            showLoading.accept(true)

            CommonService().fetchCurrency().subscribe { res in
                switch res {
                case .completed:
                    debugPrint("completed")
                case .next(let data):
                    self.currencyLists.accept(data)
                case .error(let error):
                    debugPrint(error.localizedDescription)
                }
            }.disposed(by: bag)
            showLoading.accept(false)
        }
    }

    func saveCurrencyData() {
        currencyLists.asObservable()
            .subscribe { currencyAry in
                switch currencyAry {
                case.next(let data):
                    if data.count > 0 {
                        DataBaseHandler().saveCurrencyData(data)
                    }
                case.completed:
                    debugPrint("completed")
                case.error(let error):
                    debugPrint(error.localizedDescription)
                }
            } .disposed(by: bag)
    }

    /**
     delete after 24 HOUR
     */
    func deleteAllCurrencyData() {
        DataBaseHandler().deleteAllCurrencyData()
    }

}
