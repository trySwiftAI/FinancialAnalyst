//
//  ContentView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputForm = InputForm()
    @State private var showingAnalysis = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    headerView
                    InputFormView(inputForm: $inputForm)
                    analyzeEarningsButton
                }
                .padding()
            }
            .navigationTitle("Financial Analyst")
            .navigationBarTitleDisplayMode(.large)
        }
        .fullScreenCover(isPresented: $showingAnalysis) {
            AnalysisView(inputForm: inputForm)
        }
    }
}

extension ContentView {
    @ViewBuilder
    private var headerView: some View {
        Text("Get comprehensive earnings analysis for any public company. Select a company, choose your timeframe, and let AI analyze the latest financial data and trends.")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.leading)
            .padding()
            .italic()
    }

    @ViewBuilder
    private var analyzeEarningsButton: some View {
        Button {
            showingAnalysis = true
        } label: {
            HStack {
                if showingAnalysis {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(.primary)
                } else {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
                Text(showingAnalysis ? "Analyzing..." : "Analyze Earnings")
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .buttonStyle(.glassProminent)
        .disabled(showingAnalysis)
        .tint(showingAnalysis ? .gray : .mint)
    }
}

#Preview {
    ContentView()
}
