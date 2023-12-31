//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import Foundation

struct Expense: Identifiable, Codable, Equatable, Hashable {
    var id = UUID().uuidString
    var timeStamp = Date()
    var expenseDate = Date()
    let name: String
    let type: String
    let amount: Double
}

let testData = [
    Expense(name: "Example Expense 1", type: "Day Subsistenace", amount: 12.00)
]
