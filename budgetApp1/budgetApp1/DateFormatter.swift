//
//  DateFormatter.swift
//  budgetApp1
//
//  Created by Lehlohonolo Nkadimeng on 2024/05/30.
//

import Foundation


class DataFormatterClass {
  
    // MARK: - Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    func formatDateString(_ dateString: String) -> String? {
        if let date = dateFormatter.date(from: dateString) {
            return displayFormatter.string(from: date)
        }
        return nil
    }
    
    func formatDate(_ date: Date) -> String {
        return displayFormatter.string(from: date)
    }
}
