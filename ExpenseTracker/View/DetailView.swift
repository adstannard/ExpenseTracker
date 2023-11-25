//
//  DetailView.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 18/11/2023.
//

import SwiftUI

struct DetailView: View {
    
    var expense: Expense
    var expenses = Expenses()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    @State private var image: UIImage?
    @State private var time: String?

    func loadImage() -> UIImage? {
        if FileManager().docExist(named: "\(expense.id).jpg") {
            let filename = FileManager.documentsDirectory.appendingPathComponent("\(expense.id).jpg")
            print("Finding \(expense.id).jpg")
            let imageData = try? Data(contentsOf: filename)
            let image = UIImage(data: imageData!)
            return image
        } else {
            let image = UIImage(systemName: "photo.fill")
            return image
        }
    }
  
//    File saved as PNG or JPEG does not contain DateTimeOriginal in EXIF as this is stripped
    
//    func imageEXIF() -> String? {
//        if FileManager().docExist(named: "\(expense.id).jpg") {
//            let filename = FileManager.documentsDirectory.appendingPathComponent("\(expense.id).jpg")
//            print("Getting EXIF data")
//            let  cgiSrc = CGImageSourceCreateWithURL(filename as CFURL, nil)
//            let cfD:CFDictionary = CGImageSourceCopyPropertiesAtIndex(cgiSrc!, 0, nil)!
//            let nsDic = NSDictionary(dictionary: cfD)
//            print(nsDic.description)
//            return nsDic.description
//        } else {
//            return "no timestamp found"
//        }
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
                Label("Expense Age:", systemImage: "clock")
                    .font(.headline)
                Spacer()
                Text("\(expenses.dayCount(expenseDate: expense.expenseDate)) days (Claim in \(90 - (expenses.dayCount(expenseDate: expense.expenseDate))) days)")
                    .font(.caption)
            }
            
            Spacer()

            
                        
            Group {
                if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .overlay(
                                VStack {
                                    Label("Receipt Photo Timestamp:", systemImage: "camera")
                                    Text("\(expense.timeStamp.formatted(date: .numeric, time: .complete))")
                                }
                                .font(.caption2)
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

        }
        .padding(.horizontal)
        .navigationTitle(expense.name)
        .task {
            if FileManager().docExist(named: "\(expense.id).jpg") {
                image = loadImage()
 //               time = imageEXIF()
            }
        }
    }
}

#Preview {
    DetailView(expense: testData[0])
}
