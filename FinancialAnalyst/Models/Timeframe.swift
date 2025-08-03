//
//  Timeframe.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//

import Foundation

enum Timeframe: String, CaseIterable, Identifiable {
    case lastQuarter = "Last Quarter"
    case lastYear = "Last Year"
    case lastTwoYears = "Last 2 Years"
    case yearToDate = "Year-to-Date"
    case lastSixMonths = "Last 6 Months"
    
    var id: String {
        return self.rawValue
    }
}
