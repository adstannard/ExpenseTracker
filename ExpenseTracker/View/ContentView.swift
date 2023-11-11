//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 09/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var totalExpense = 0.0
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("Total")) {
                    Text("£\(totalExpense)")
                }
                Section(header: Text("Expense Items")) {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: "GBP"))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("Expense Tracker")
            .onAppear(perform: expenseTotal)
            
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func expenseTotal() {
        for item in expenses.items {
            totalExpense += item.amount
        }
    }
    
    
    
}

#Preview {
    ContentView()
}
