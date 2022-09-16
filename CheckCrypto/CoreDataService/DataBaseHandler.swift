//
//  DataBaseHandler.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/13/22.
//

import Foundation
import RxSwift
import RealmSwift
class DataBaseHandler  {
    
    func saveCurrencyData(_ objects: [CurrencyData]) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(objects,update: .all)
            }
        }
    }
    
    func getCurrencyData() -> Observable<[CurrencyData]> {
        let realm = try! Realm()
        return Observable.just(Array(realm.objects(CurrencyData.self)))
    }
    
    func deleteAllCurrencyData() {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write{
                try! realm.delete(Realm().objects(CurrencyData.self))
            }
        }
    }
}
