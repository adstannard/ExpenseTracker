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
    
//   func loadImage() -> UIImage {
//       let filename = FileManager.documentsDirectory.appendingPathComponent("\(expense.id).png")
//           print("Finding \(expense.id).png")
//           let imageData = try? Data(contentsOf: filename)
//           if let image = UIImage(data: imageData) {
//               return image
//       }
//    }
    
    
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
        
            HStack {
                Label("Receipt Photo Timestamp:", systemImage: "camera")
                Text(expense.timeStamp, format: .dateTime.hour().minute().second())
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top)
            
            Text("\(expense.id)")
//            Image(uiImage: UIImage( loadImage())
            
//            Group {
//                if let image = loadImage() {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            
//                } else {
//                    Image(systemName: "photo.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .opacity(0.1)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding(.horizontal)
//                }
//            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .navigationTitle(expense.name)
    }
}

#Preview {
    DetailView(expense: testData[0])
}
