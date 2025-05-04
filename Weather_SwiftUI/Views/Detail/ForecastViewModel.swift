//
//  ForecastViewModel.swift
//  Weather_SwiftUI
//
//  Created by name on 04/05/2025.
//

import Foundation

@MainActor
class ForecastViewModel: ObservableObject {
    
    @Published var CurrentWeatherForecasts: Forecast?
    
    @Published var forecasts: [Forecast] = []
    @Published var loading: Bool = true
    
    init() {getForecasts()}
    
    func getForecasts() {
        Task {
            do {
                let result = try await ForecastRequest().perform()
                
                CurrentWeatherForecasts = result.first
                forecasts = result
                
                
                loading = false
            } catch {
                print(error.localizedDescription)
                loading = false
            }
        }
    }
}
