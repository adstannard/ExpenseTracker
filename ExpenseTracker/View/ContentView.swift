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
 //   @State private var totalExpense = 0.0
    
    var body: some View {
        NavigationView {
            List {
                Section(footer: Text("Total")) {
                    Text(expenses.totalExpense, format: .currency(code: "GBP"))
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
            .onAppear(perform: expenses.expenseTotal)
            
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
        expenses.expenseTotal()
    }
    
//    func expenseTotal() {
//        expenses.totalExpense = 0.0
//        for item in expenses.items {
//            expenses.totalExpense += item.amount
//        }
//    }
    
    
    
}

#Preview {
    ContentView()
}
