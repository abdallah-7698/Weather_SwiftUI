//
//  SegmentedControl.swift
//  Weather_SwiftUI
//
//  Created by name on 29/04/2025.
//

import SwiftUI

struct SegmentedControl: View {
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        selectedIndex = 0
                    }
                } label: {
                    Text("Hourly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        selectedIndex = 1
                    }
                } label: {
                    Text("Weakly Forecast")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .opacity(0.5)
            
            Divider()
                .background(.white)
                .opacity(0.5)
                .blendMode(.overlay)
                .shadow(color:.black.opacity(0.2) ,radius: 0 ,x: 0 ,y: 1)
                .blendMode(.overlay)
                .overlay {
                    HStack {
                        Divider()
                            .frame(width: UIScreen.main.bounds.width / 2, height: 3)
                            .background(Color.underline)
                            .blendMode(.overlay)
                    }
                    .frame(maxWidth: .infinity, alignment: selectedIndex == 0 ? .leading : .trailing)
                    .offset(y: -1)
                }
            
        }.padding(.top, 25)
    }
}

#Preview {
    SegmentedControl(selectedIndex: .constant(0))
        .preferredColorScheme(.dark)
}
