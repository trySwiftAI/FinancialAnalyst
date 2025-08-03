//
//  InputFormView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//

import SwiftUI

struct InputFormView: View {
    @Binding var inputForm: InputForm
    
    var body: some View {
        VStack(spacing: 20) {
            companySelectionView
            timeframeSelectionView
            additionalQuestionView
        }
    }
}

extension InputFormView {
    @ViewBuilder
    private var companySelectionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            selectHeaderView(withText: "Select Company")
            
            Menu {
                ForEach(Company.allCases) { company in
                    Button(company.rawValue) {
                        inputForm.selectedCompany = company
                    }
                }
            } label: {
                selectionItemView(from: inputForm.selectedCompany.rawValue)
            }
        }
    }
    
    @ViewBuilder
    private var timeframeSelectionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            selectHeaderView(withText: "Timeframe")
            
            Menu {
                ForEach(Timeframe.allCases) { timeframe in
                    Button(timeframe.rawValue) {
                        inputForm.selectedTimeframe = timeframe
                    }
                }
            } label: {
                selectionItemView(from: inputForm.selectedTimeframe.rawValue)
            }
        }
    }
    
    @ViewBuilder
    private func selectHeaderView(withText text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.primary)
    }
    
    @ViewBuilder
    private func selectionItemView(from item: String) -> some View {
        HStack {
            Text(item)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private var additionalQuestionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Additional Question (Optional)")
                .font(.headline)
                .foregroundColor(.primary)
            
            TextField("Ask about specific metrics, trends, or comparisons...", text: $inputForm.additionalQuestion, axis: .vertical)
                .textFieldStyle(.plain)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .lineLimit(3...6)
        }
    }
}

