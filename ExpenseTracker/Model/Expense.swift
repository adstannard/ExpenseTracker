//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    let name: String
    let expenseDate: Date
    let timeStamp: Date
    let type: String
    let amount: Double
}
