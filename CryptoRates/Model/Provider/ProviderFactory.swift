//
//  ProviderFactory.swift
//  CryptoRates
//
//  Created by Admin on 10/06/2020.
//

import Foundation


enum ProviderType {
    case QuoteProvider
    case HistoricalProvider
}


class ProviderFactory {
    
    static var instance: ProviderFactory = {
        let instance = ProviderFactory()
        return instance
    }()
    
    private init(){}
    
    static func getProvider(type: ProviderType, symbol: String = "") -> Provider {
        switch type {
        case .QuoteProvider:
            return QuoteProvider()
        case .HistoricalProvider:
            return HistoricalProvider(symbol: symbol)
        }
    }
    
}

extension ProviderFactory: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

fileprivate class QuoteProvider: Provider {
    
    internal var realmDAO: RealmDAO
    internal var networkDataFetcher : NetworkDataFetcher
    internal var timer: Timer?
    
    init() {
        realmDAO = RealmDAO()
        networkDataFetcher = NetworkDataFetcher.instance
    }
    
    internal func sendNotification() {
        NotificationCenter.default.post(name: NotificationConstants.notificationName, object: nil, userInfo: nil)
    }
    
    //timer
    public func reloadTimer() {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { timer in
            self.getDataFromNetwork()
        }
    }
    
    public func getDataFromDatabase() -> [Cached] {
        return realmDAO.readQuoteData()
    }
    
    public func getDataFromNetwork () {
        networkDataFetcher.fetchQuotes(urlString: Constants.quotesUrlString) { (webResponse) in
            if let unwrappedQuote = webResponse {
                 DispatchQueue.main.async {
                    self.realmDAO.saveQuoteData(quote: unwrappedQuote )
                     self.sendNotification()
                 }
            }
        }
    }
    
}

fileprivate class HistoricalProvider: Provider  {
    
    internal var realmDAO : RealmDAO
    internal var networkDataFetcher : NetworkDataFetcher
    internal var timer: Timer?
    private let symbol: String
    
    init(symbol : String) {
        self.symbol = symbol
        realmDAO = RealmDAO()
        networkDataFetcher = NetworkDataFetcher.instance
        self.getDataFromNetwork()
    }
    
    internal func sendNotification() {
        NotificationCenter.default.post(name: NotificationConstants.notificationHist, object: nil, userInfo: nil)
    }
    
    //timer
    public func reloadTimer() {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.getDataFromNetwork()
        }
    }
    
    public func getDataFromDatabase() -> [Cached] {
        realmDAO.readHistoricalData(primaryKey: symbol)
    }
    
    public func getDataFromNetwork () {
        networkDataFetcher.fetchHist(urlString: "https://min-api.cryptocompare.com/data/v2/histoday?fsym=\(symbol)&tsym=USD&limit=365") { (webResponse) in
            DispatchQueue.main.async {
                self.realmDAO.saveHistoricalData(histData: webResponse.data.data, primaryKey: self.symbol)
                self.sendNotification()
            }
       }
    }
    
}
