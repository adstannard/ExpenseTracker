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
    @State private var searchText = ""
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    var searchResults: [Expense] {
        if searchText.isEmpty {
            return expenses.items
        } else {
            return expenses.items.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(footer: Text("Total")) {
                    Text(expenses.totalExpense, format: .currency(code: "GBP"))
                }
                Section(header: Text("Expense Items")) {
                    ForEach(searchResults, id: \.self) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .font(.caption)
                                Text(dateFormatter.string(from: item.expenseDate))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
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
        .searchable(text: $searchText, prompt: "Search expenses")
    }
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        expenses.expenseTotal()
        expenses.save()
    }
    
}

#Preview {
    ContentView()
}
