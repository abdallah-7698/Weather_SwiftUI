//
//  ForecastCard.swift
//  Weather_SwiftUI
//
//  Created by name on 29/04/2025.
//

import SwiftUI

struct ForecastCard: View {
    
    var forecast: Forecast
    var forecastPeriod: ForecastPeriod
    
    var isActive: Bool {
        if forecastPeriod == ForecastPeriod.hourly {
            let isThisHoure = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .hour)
            return isThisHoure
        } else {
            let isToday = Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: .day)
            return isToday
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground)
                .opacity(isActive ? 1 : 0.2)
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30),color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 0, blendModel: .overlay)
            
            VStack(spacing: 16) {
                Text(forecast.date, format: forecastPeriod == ForecastPeriod.hourly ? .dateTime.hour() : .dateTime.day())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                VStack (spacing: -4) {
                    Image(forecast.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 65)
                    
                }
                .frame(height: 42)
                
                Text("\(forecast.temperature)°")
                    .font(.title3)
                
            }
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 61, height: 146)
            
            
        }
    }
}

#Preview {
    ForecastCard(forecast: Forecast.hourly[1], forecastPeriod: ForecastPeriod.hourly)
}
