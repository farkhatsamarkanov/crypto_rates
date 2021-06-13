import Foundation
import RealmSwift

protocol Cached {}


class QuoteCached: Object, Cached {
    @objc dynamic var name = ""
    @objc dynamic var fullName = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var lastUpdate = ""
    @objc dynamic var fromSymbol = ""
    @objc dynamic var toSymbol = ""
    @objc dynamic var priceUSD = ""
    @objc dynamic var priceDouble = ""
    @objc dynamic var volume24Hour = ""
    @objc dynamic var volume24HourTo = ""   
    @objc dynamic var open24Hour = ""       //
    @objc dynamic var high24Hour = ""       //
    @objc dynamic var low24Hour = ""        //
    @objc dynamic var changepct24Hour = ""
    @objc dynamic var supply = ""
    @objc dynamic var marketCapUSD = ""
    @objc dynamic var totalVolume24Hour = ""
    @objc dynamic var totalVolume24HourTo = ""
}

class HistoricalDatumCached: Object, Cached {
    @objc dynamic var time: Int = 0
    @objc dynamic var close: Double = 0
}

class HistoricalDataCached: Object, Cached {
    var data = List<HistoricalDatumCached>()
    @objc dynamic var symbol = ""
    
    override class func primaryKey() -> String? {
        return "symbol"
    }
}
