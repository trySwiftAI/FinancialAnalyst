//
//  Double+Extensions.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import Foundation

extension Double {
    func currencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if self >= 1_000_000_000 {
            return (formatter.string(from: NSNumber(value: self / 1_000_000_000)) ?? "0") + " Billion"
        } else if self >= 1_000_000 {
            return (formatter.string(from: NSNumber(value: self / 1_000_000)) ?? "0") + " Million"
        } else {
            formatter.maximumFractionDigits = 0
            return "$" + (formatter.string(from: NSNumber(value: self)) ?? "0")
        }
    }
}