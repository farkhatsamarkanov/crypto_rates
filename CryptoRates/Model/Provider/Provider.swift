//
//  Provider.swift
//  CryptoRates
//
//  Created by Admin on 08/06/2020.
//

import Foundation

protocol Provider {
    var realmDAO : RealmDAO { get set }
    var networkDataFetcher : NetworkDataFetcher { get set }
    var timer: Timer? { get set }
    
    func sendNotification()
    
    func reloadTimer()
    
    func getDataFromDatabase() -> [Cached]
    
    func getDataFromNetwork()
    
}
