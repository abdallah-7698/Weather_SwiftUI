//
//  HomeView.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.91 // 702/844
    case middle = 0.385 // 325/844
}

struct HomeView: View {
    
    @State private var isOpen: Bool = false
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
        
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                
                ZStack(alignment: .top) {
                    Color.background
                        .ignoresSafeArea(.all)
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea(.all)
                    
                    Image("House")
                        .padding(.top, 257)
                    
                    VStack(spacing: 0) {
                        Text("Montreal")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        VStack(spacing: -10) {
                            Text("28°")
                                .font(.system(size: 96, weight: .thin))
                                .foregroundColor(.white)
                            
                            Text("Mostly Clear")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        
                        Text("H:28°   L:18°")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.top, 51)
                    
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrated.formatted())
                    } content: {
                        ForecastView(isOpen: $isOpen)
                            .frame(height: screenHeight)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                        
                        withAnimation(.easeInOut) {
                            if bottomSheetPosition == BottomSheetPosition.top {
                                isOpen = true
                            } else {
                                isOpen = false
                            }
                        }
                    }
                    
                    
                    
                    TabBar(action: {})
                    
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
