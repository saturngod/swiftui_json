//
//  Extensions.swift
//  NewsArticles
//
//  Created by Htain Lin Shwe on 30/11/2023.
//

import Foundation

extension Date {
    func ago() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day, .month,.year], from: self, to: now)

        if let years = components.year, years > 0 {
            return "\(years)y ago"
        }
        else if let months = components.month, months > 0 {
            return "\(months)m ago"
        } else if let days = components.day, days > 0 {
            return "\(days)d ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m ago"
        } else {
            return "Now"
        }
    }
    
    func localFormat() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .medium)
    }
}
