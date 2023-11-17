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
    
    @State private var showPicker = false
    @State private var image: UIImage?
    
    let types = ["Day Subsistence", "Night Subsistence", "Fuel", "Motor Milage"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Expense Details")) {
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
                }
                .frame(maxHeight: 250)
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
                
                Button {
                    print("Button tapped")
                    showPicker.toggle()
                } label: {
                    Label("Camera", systemImage: "camera")
                        .padding()
                        .frame(height: 45)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .cornerRadius(15)
                }
                .padding()
                
                Spacer()
                
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(sourceType: .camera, selectedImage: $image)
                    .ignoresSafeArea()
            }
        }
        

        
        
    }
    
}
#Preview {
    AddView(expenses: Expenses())
}
