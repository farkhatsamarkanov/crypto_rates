import Foundation
import RealmSwift

class RealmDAO {
    
    func saveQuoteData(quote:Quote) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(QuoteCached.self)
                realm.delete(result)
                let quotesRealm = convertQuoteToRealm(quote: quote)
                for i in quotesRealm {
                    realm.add(i)
                }
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func saveHistoricalData(histData:[HistoricalDatum], primaryKey: String) {
        do {
            let realm = try! Realm()
            try realm.write {
                let result = realm.objects(HistoricalDataCached.self)
                realm.delete(result)
                let monthsAvgRealm = convertHistoricalDataToRealm(historicalData: histData, primaryKey: primaryKey)
                
                realm.add(monthsAvgRealm)
                
            }
        } catch {
            print("Error while writing to Realm: \(error)")
        }
    }
    
    func readHistoricalData(primaryKey: String) -> [HistoricalDatumCached] {
        var historicalDataCached: [HistoricalDatumCached] = []
        do {
            let realm = try Realm()
            let result = realm.object(ofType: HistoricalDataCached.self, forPrimaryKey: primaryKey)
            if let data = result?.data {
                for histDatum in data {
                    historicalDataCached.append(histDatum)
                }
            }
            
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return historicalDataCached
    }
    
    func readQuoteData() -> [QuoteCached] {
        var quotes: [QuoteCached] = []
        do {
            let realm = try Realm()
            let result = realm.objects(QuoteCached.self)
            for quote in result {
                quotes.append(quote)
            }
        } catch {
            print("Error while reading data from Realm: \(error)")
        }
        return quotes
    }
    
    
    func convertHistoricalDataToRealm (historicalData: [HistoricalDatum], primaryKey:String) -> HistoricalDataCached {
        let dataCachedRealm = HistoricalDataCached()
        for datum in historicalData {
            let datumCachedRealm = HistoricalDatumCached()
            datumCachedRealm.time = datum.time
            datumCachedRealm.close = datum.close
            dataCachedRealm.data.append(datumCachedRealm)
        }
        dataCachedRealm.symbol = primaryKey
        return dataCachedRealm
    }
    
    func convertQuoteToRealm(quote: Quote) -> [QuoteCached] {
        var quotesRealm: [QuoteCached] = []
        for datum in quote.data {
            let quoteRealm = QuoteCached()
            quoteRealm.name = datum.coinInfo.name
            quoteRealm.fullName = datum.coinInfo.fullName
            quoteRealm.imageURL = datum.coinInfo.imageURL
            quoteRealm.lastUpdate = "\(datum.raw.usd.lastupdate)"
            quoteRealm.fromSymbol = datum.display.usd.fromsymbol
            quoteRealm.toSymbol = datum.display.usd.tosymbol
            quoteRealm.priceUSD = datum.display.usd.price
            quoteRealm.volume24Hour = datum.display.usd.volume24Hour
            quoteRealm.volume24HourTo = datum.display.usd.volume24Hourto
            quoteRealm.open24Hour = datum.display.usd.open24Hour
            quoteRealm.high24Hour = datum.display.usd.high24Hour
            quoteRealm.low24Hour = datum.display.usd.low24Hour
            quoteRealm.changepct24Hour = datum.display.usd.changepct24Hour
            quoteRealm.supply = datum.display.usd.supply
            quoteRealm.marketCapUSD = datum.display.usd.mktcap
            quoteRealm.totalVolume24Hour = datum.display.usd.totalvolume24H
            quoteRealm.totalVolume24HourTo = datum.display.usd.totalvolume24Hto
            quoteRealm.priceDouble = "\(datum.raw.usd.price)"
            quotesRealm.append(quoteRealm)
        }
        return quotesRealm
    }
    
}
