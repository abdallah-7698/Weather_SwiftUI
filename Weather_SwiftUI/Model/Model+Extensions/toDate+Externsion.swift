//
//  Date+Externsion.swift
//  Weather_SwiftUI
//
//  Created by name on 04/05/2025.
//

import Foundation


extension Int {
    // Function to convert Int (timestamp) to Date
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

