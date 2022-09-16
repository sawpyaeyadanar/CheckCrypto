//
//  CurrencyRate.swift
//  CheckCrypto
//
//  Created by sawpyae on 9/9/22.
//

import Foundation
import RealmSwift
import ObjectMapper

class ResponseData: Object, Mappable {

    @Persisted var bpi: BPI?

    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }

    func mapping(map: ObjectMapper.Map) {
        bpi <- map["bpi"]
    }
}

// MARK: - Bpi
class BPI: Object,Mappable {
    @Persisted var USD : CurrencyData?
    @Persisted var GBP : CurrencyData?
    @Persisted var EUR: CurrencyData?

    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }

    func mapping(map: ObjectMapper.Map) {
        USD <- map["USD"]
        EUR <- map["EUR"]
        GBP <- map["GBP"]

    }
}

// MARK: - Eur
class CurrencyData: Object, Mappable {
    @Persisted var code : String?
    @Persisted var symbol : String?
    @Persisted var rate : String?
    @Persisted var currencyname : String?
    @Persisted var rate_float: Double?
    @Persisted var _id = UUID().uuidString
    @Persisted var time = Date()
    public override static func primaryKey() -> String? {
        return "_id"
    }
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }

    func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        symbol <- map["symbol"]
        rate <- map["rate"]
        currencyname <- map["description"]
        rate_float <- map["rate_float"]

    }

    enum CodingKeys: String, CodingKey {
        case code
        case symbol
        case rate
        case currencyname = "description"
        case rate_float

    }
}
