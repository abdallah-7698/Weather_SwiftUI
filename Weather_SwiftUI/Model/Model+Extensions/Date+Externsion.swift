//
//  Date+Externsion.swift
//  Weather_SwiftUI
//
//  Created by name on 04/05/2025.
//

import Foundation


extension Int {
    enum DateComponentType {
        case hour
        case day
    }

    // Function to convert Int (timestamp) to Date
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Date {
    enum DateComponentType {
        case hour
        case day
    }

    // Function to get the specified component (hour or day)
    func to(component: DateComponentType) -> Date {
        let calendar = Calendar.current

        switch component {
        case .hour:
            return self // Return the full timestamp with hour (no change needed here)
        case .day:
            let components = calendar.dateComponents([.year, .month, .day], from: self)
            return calendar.date(from: components) ?? self // Return the date with just the day
        }
    }
}
