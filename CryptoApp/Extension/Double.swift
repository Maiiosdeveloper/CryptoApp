//
//  Double.swift
//  CryptoApp
//
//  Created by Mai on 13/07/2024.
//

import Foundation
extension Double {
    /// Converts a Double to a currency with 2-6 decimal places
    /// ```
    /// Convert 57849.411812135164 to "$57,849.411812"
    /// ```
    private var concurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .init(identifier: "en")
        //formatter.currencyCode = "usd" // usd is default
        //formatter.currencySymbol = "$" // $ is default
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    var addCurrency: String{
        let number = NSNumber(floatLiteral: self)
        return concurrencyFormatter.string(from: number) ?? "$0.00"
    }
    /// Converts a Double to a readable number
    /// ```
    /// Convert 4.411812135164 to "4.41"
    /// ```
    var addReadableNummber: String {
        String(format: "%.2f", self)
    }
    /// Converts a Double to a percentage number
    /// ```
    /// Convert 4.411812135164 to "4.41%"
    /// ```
    var addPercentage: String {
        addReadableNummber+"%"
    }
    
    var addFormattedWithAbbreviations: String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.addReadableNummber
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.addReadableNummber
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.addReadableNummber
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.addReadableNummber
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.addReadableNummber

        default:
            return "\(sign)\(self)"
        }
    }
}
