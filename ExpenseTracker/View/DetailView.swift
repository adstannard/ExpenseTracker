//
//  DetailView.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 18/11/2023.
//

import SwiftUI

struct DetailView: View {
    
    var expense: Expense
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(expense.name)
                .font(.largeTitle)
                .padding(20)
            HStack {
                Label("Amount:", systemImage: "sterlingsign.circle.fill")
                    
                Spacer()
                Text(expense.amount, format: .currency(code: "GBP"))
                Spacer()
            }
            .font(.title2)
            
            HStack {
                Label("Expense Type:", systemImage: "menucard")
                    .font(.headline)
                Spacer()
                Text(expense.type)
            }
            .padding(.top)
            
            HStack {
                Label("Expense Date:", systemImage: "calendar")
                    .font(.headline)
                Spacer()
                Text(dateFormatter.string(from: expense.expenseDate))
                    .font(.caption)
            }
            
           
            HStack {
                Label("Receipt Photo Timestamp:", systemImage: "camera")
                Text(expense.timeStamp, format: .dateTime.hour().minute().second())
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top)
            Spacer()
            
        }
        .padding(.horizontal)
        .navigationTitle(expense.name)
    }
}

#Preview {
    DetailView(expense: testData[0])
}
