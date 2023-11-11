//
//  Expenses.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import Foundation

@Observable
class Expenses: Equatable {
    static func == (lhs: Expenses, rhs: Expenses) -> Bool {
        return lhs.items == rhs.items
    }
    var totalExpense = 0.0
    
    func expenseTotal() {
        totalExpense = 0.0
        for item in items {
            totalExpense += item.amount
        }
    }
    
    
    var items = [Expense]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Expense].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
