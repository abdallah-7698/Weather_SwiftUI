//
//  WeatherView.swift
//  Weather_SwiftUI
//
//  Created by name on 29/04/2025.
//

import SwiftUI

struct WeatherView: View {

    let forecastModel: [Forecast] = Forecast.cities
    
    private var searchResults: [Forecast] {
        if searchText.isEmpty {
            return forecastModel
        } else {
            return forecastModel.filter {
                $0.location.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            
            Color
                .background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(searchResults) { forecast in
                        WeatherWidget(forecast: forecast)
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: 110)
            }
            
        }
        .overlay {
            NavigationBar(searchText: $searchText)
        }
    }
}

#Preview {
    NavigationView {
        WeatherView()
    }
        
}
