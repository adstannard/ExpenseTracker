//
//  DetailView.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 18/11/2023.
//

import SwiftUI

struct DetailView: View {
    
    var expense: Expense
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    @State private var image: UIImage?
    
    func loadImage() -> UIImage? {
        if FileManager().docExist(named: "\(expense.id).png") {
            let filename = FileManager.documentsDirectory.appendingPathComponent("\(expense.id).png")
            print("Finding \(expense.id).png")
            let imageData = try? Data(contentsOf: filename)
            let image = UIImage(data: imageData!)
            return image
        } else {
            let image = UIImage(systemName: "photo.fill")
            return image
        }
    }
       
    
    var body: some View {
        VStack {
            HStack {
                Label("Amount:", systemImage: "sterlingsign.circle.fill")
                    
                Spacer()
                Text(expense.amount, format: .currency(code: "GBP"))
                Spacer()
            }
            .font(.title2)
            
            HStack {
                Label("Expense Type:", systemImage: "menucard")
                    .font(.headline)
                Spacer()
                Text(expense.type)
            }
            .padding(.top)
            
            HStack {
                Label("Expense Date:", systemImage: "calendar")
                    .font(.headline)
                Spacer()
                Text(dateFormatter.string(from: expense.expenseDate))
                    .font(.caption)
            }
            Spacer()
// Image timestamp added to image overlay so removed here
            
//            HStack {
//                Label("Receipt Photo Timestamp:", systemImage: "camera")
//                Text(expense.timeStamp, format: .dateTime.hour().minute().second())
//            }
//            .font(.caption)
//            .foregroundStyle(.secondary)
//            .padding(.top)
            
                        
            Group {
                if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .overlay(
                                HStack {
                                    Label("Receipt Photo Timestamp:", systemImage: "camera")
                                    Text(expense.timeStamp, format: .dateTime.hour().minute().second())
                                }
                                .font(.caption)
                                .padding(5)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(15)
                                .padding(),
                                alignment: .bottom
                            )
                            
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
// Show the id of the expense
            
//            Text("\(expense.id)")
//                .font(.caption2)
//                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
        .navigationTitle(expense.name)
        .task {
            if FileManager().docExist(named: "\(expense.id).png") {
                image = loadImage()
            }
        }
    }
}

#Preview {
    DetailView(expense: testData[0])
}
