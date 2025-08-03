//
//  AnalysisView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import FoundationModels
import SwiftUI

struct AnalysisView: View {
    @Environment(\.dismiss) private var dismiss
    
    let inputForm: InputForm
    
    private let client = PerplexityClient()
    @State private var isGenerating = false
    @State private var generatedAnalysis: GeneratedFinancialAnalysis?
    
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if let analysis = generatedAnalysis {
                    analysisContent(analysis)
                } else if let errorMessage = errorMessage {
                    errorStateView(withErrorMessage: errorMessage)
                        .padding(.bottom, 200)
                } else {
                    loadingView
                        .padding(.bottom, 150)
                }
            }
            .background(.background)
            .navigationTitle("Financial Analysis")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    dismissButton
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    retryButton
                }
            }
            .task {
                performAnalysis()
            }
        }
    }
}

extension AnalysisView {
    private func performAnalysis() {
        errorMessage = nil
        isGenerating = true
        generatedAnalysis = nil
        
        Task {
            do {
                let analysisPrompt = inputForm.generatePrompt()
                for try await partial in client.streamResponse(for: analysisPrompt) {
                    do {
                        let generatedContent = try GeneratedContent(json: partial)
                        let partiallyGeneratedAnalysis = try GeneratedFinancialAnalysis(generatedContent)
                        
                        await MainActor.run {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                generatedAnalysis = partiallyGeneratedAnalysis
                            }
                        }
                    } catch {
                        print("Error processing partial response: \(error)")
                    }
                }
                
                await MainActor.run {
                    // save the final generated analysis in SwiftData or the server
                    isGenerating = false
                }
                
            } catch {
                await MainActor.run {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        errorMessage = "Error generating analysis: \(error)"
                        isGenerating = false
                    }
                }
            }
        }
    }
}

extension AnalysisView {
    @ViewBuilder
    private func analysisContent(
        _ analysis: GeneratedFinancialAnalysis
    ) -> some View {
        ScrollView {
            if let analysis = generatedAnalysis?.analysis {
                VStack(spacing: 20) {
                    if let company = analysis.company, let quarter = analysis.quarter {
                        CompanyHeaderView(company: company, quarter: quarter)
                    }
                    MetricsGrid(analysis: analysis)
                    if let growth = analysis.revenue_growth_yoy {
                        RevenueGrowthView(growth: growth)
                    }
                    if let highlights = analysis.key_highlights {
                        if !highlights.isEmpty {
                            KeyHighlightsView(highlights: highlights)
                        }
                    }
                }
            }
            if !analysis.search_results.isEmpty {
                SearchResultsView(searchResults: analysis.search_results)
            }
        }
    }
    
    
    @ViewBuilder
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.mint)
            
            Text("Analyzing \(inputForm.selectedCompany.rawValue)")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Fetching latest financial data...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func errorStateView(
        withErrorMessage errorMessage: String
    ) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.mint)
            
            Text("Oops!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Button {
                performAnalysis()
            } label: {
                Text("Try again")
                    .padding(5)
            }
            .buttonStyle(.glassProminent)
            .tint(.mint)
        }
    }
}

extension AnalysisView {
    @ViewBuilder
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Label("Close", systemImage: "x.circle")
                .labelStyle(.iconOnly)
        }
    }
    
    @ViewBuilder
    private var retryButton: some View {
        Button {
            performAnalysis()
        } label: {
            Label("Retry", systemImage: "arrow.clockwise")
                .labelStyle(.iconOnly)
        }
        .disabled(isGenerating)
    }
}

#Preview {
    AnalysisView(inputForm: InputForm())
}
