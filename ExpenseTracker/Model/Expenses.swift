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
    
    // Attempt to work with file storage in Document Directory
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedExpenses")
    
    var items = [Expense]()
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([Expense].self, from: data)
        } catch {
            items = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}
