//
//  AddView.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Day Subsistence"
    @State private var expenseDate = Date.now
    @State private var amount = 0.0
    
    let types = ["Day Subsistence", "Night Subsistence", "Fuel", "Motor Milage"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                DatePicker(selection: $expenseDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Expense Date")
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "GBP"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = Expense(expenseDate: expenseDate, name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    expenses.expenseTotal()
                    expenses.save()
                    dismiss()
                }
            }
        }
    }
    
}
#Preview {
    AddView(expenses: Expenses())
}
