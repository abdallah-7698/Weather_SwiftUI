//
//  ToCelsius+Extension.swift
//  Weather_SwiftUI
//
//  Created by name on 04/05/2025.
//

import Foundation

extension Double {
    
     func toCelsius()->Self{
        return (self - 273.15).rounded(toPlaces: 2)
    }
    
    private func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
