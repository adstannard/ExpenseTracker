//
//  FileManager-DocDir.swift
//  ExpenseTracker
//
//  Created by Andrew Stannard on 11/11/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: FileManager.documentsDirectory.appendingPathComponent(docName).path)
    }
    
    
}
