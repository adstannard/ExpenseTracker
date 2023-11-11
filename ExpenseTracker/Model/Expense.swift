//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable {
    var id = UUID()
    var timeStamp = Date()
    var expenseDate = Date()
    let name: String
    let type: String
    let amount: Double
}
