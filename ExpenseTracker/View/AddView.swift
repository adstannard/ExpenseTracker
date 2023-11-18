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
    
    @State private var id = UUID()
    @State private var name = ""
    @State private var type = "Day Subsistence"
    @State private var expenseDate = Date.now
    @State private var amount = 0.0
    @State private var time: Date?
    
    @State private var showPicker = false
    @State private var image: UIImage?
    
    let types = ["Day Subsistence", "Night Subsistence", "Fuel", "Motor Milage"]
    
    func saveImage( id: UUID, image: UIImage) {
        if let data = image.pngData() {
            let filename = FileManager.documentsDirectory.appendingPathComponent("\(id).png")
            try? data.write(to: filename)
            print("Saved \(id).png")
        }
    }

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
                        let item = Expense(timeStamp: time ?? Date.now, expenseDate: expenseDate, name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        expenses.expenseTotal()
                        expenses.save()
                        if image !== nil {
                            saveImage(id: id, image: image!)
                        }
                        dismiss()
                    }
            }
                
                Button {
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
                
                Group {
                    if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.1)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                }
                
                Spacer()
                
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(sourceType: .camera, selectedImage: $image, timeTaken: $time)
                    .ignoresSafeArea()
            }
        }
    }
}


#Preview {
    AddView(expenses: Expenses())
}
