//
//  NotificationConstants.swift
//  CryptoRates
//
//  Created by Admin on 25/06/2020.
//

import Foundation

enum NotificationConstants {
    static let notificationName = NSNotification.Name(rawValue: "sentQuotes")
    static let notificationHist = NSNotification.Name(rawValue: "sentHist")
    static let chosenQuoteNotificationName = NSNotification.Name(rawValue: "quoteChosen")
}
