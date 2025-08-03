//
//  Analysis.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import Foundation
import FoundationModels

@Generable
struct GeneratedFinancialAnalysis {
    var citations: [String] = []
    var search_results: [SearchResult] = []
    var choices: [Choices] = []
    
    var analysis: Analysis? {
        if let analsysJSON = choices.first?.message.content {
            do {
                let generatedAnalysis = try GeneratedContent(json: analsysJSON)
                return try Analysis(generatedAnalysis)
            } catch {
                print("Error generating Financial Analysis: \(error)")
                return nil
            }
        }
        return nil
    }
}

extension GeneratedFinancialAnalysis {
    
    @Generable
    struct Choices {
        var index: Int
        var message: Message
        var delta: Message
    }
    
    @Generable
    struct Message {
        var role: String
        var content: String
    }
    
    @Generable
    struct SearchResult {
        var title: String?
        var url: String?
        var date: String?
        var last_updated: String?
    }
    
    @Generable
    struct Analysis {
        var company: String?
        var quarter: String?
        var revenue: Double?
        var net_income: Double?
        var eps: Double?
        var revenue_growth_yoy: Double?
        var key_highlights: [String]?
    }
}
