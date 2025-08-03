//
//  Company.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//
 
import Foundation

enum Company: String, CaseIterable, Identifiable {
    case amazon = "Amazon.com, Inc."
    case apple = "Apple Inc."
    case google = "Alphabet Inc."
    case meta = "Meta Platforms, Inc."
    case microsoft = "Microsoft Corporation"
    case netflix = "Netflix, Inc."
    case nvidia = "NVIDIA Corporation"
    case tesla = "Tesla, Inc."
    
    var id: String {
        return self.rawValue
    }
}