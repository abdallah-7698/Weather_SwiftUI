//
//  ForecastView.swift
//  Weather_SwiftUI
//
//  Created by name on 28/04/2025.
//

import SwiftUI

struct ForecastView: View {
    
    var bottomSheetTranslationProrated: CGFloat = 1
    
    @State private var selectedForecast: Int = 0
    
    var forecastModels: [Forecast] {
        selectedForecast == 0 ? Forecast.hourly :  Forecast.daily
    }
    
    var body: some View {

                ScrollView {
                    VStack(spacing: 0) {
                        SegmentedControl(selectedIndex: $selectedForecast)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(forecastModels) { forecast in
                                    ForecastCard(forecast: forecast, forecastPeriod: selectedForecast == 0 ? .hourly : .daily)
                                        .transition(.offset(x: selectedForecast == 0 ? -430 :  430))
                                }
                            }
                            .padding(.vertical, 12)
                        }
                        .padding(.horizontal, 20)
                        
                        Image("Forecast Widgets")
                            .opacity(bottomSheetTranslationProrated)
                        
                    }
                }
                .backgroundBlur(radius: 25, opaque: true)
                .background(Color.bottomSheetBackground)
                .clipShape(RoundedRectangle(cornerRadius: 44))
                .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 1, offsetY: 1,blur: 0, blendModel: .overlay, opacity: 1 - bottomSheetTranslationProrated )
                .overlay {
                    Divider()
                        .blendMode(.overlay)
                        .background(Color.bottomSheetBorderTop)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .clipShape(RoundedRectangle(cornerRadius: 44))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 0.3)
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 60, height: 6 )
                        .frame(height: 20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
            
    }
}

#Preview {
    ForecastView()
        .background(Color.background)
}
