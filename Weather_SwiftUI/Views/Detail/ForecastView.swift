//
//  ForecastView.swift
//  Weather_SwiftUI
//
//  Created by name on 28/04/2025.
//

import SwiftUI

struct ForecastView: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {

                ScrollView {
                     
                }
                .backgroundBlur(radius: 25, opaque: true)
                .background(Color.bottomSheetBackground)
                .clipShape(RoundedRectangle(cornerRadius: 44))
                .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle, lineWidth: 1, offsetX: 1, offsetY: 1,blur: 0, blendModel: .overlay, opacity: 1)
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
                        .onTapGesture { isOpen.toggle() }
                }
            
    }
}

#Preview {
    ForecastView(isOpen: .constant(true))
        .background(Color.background)
}
