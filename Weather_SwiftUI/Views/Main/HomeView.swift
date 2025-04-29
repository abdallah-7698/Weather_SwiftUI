//
//  HomeView.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.81 // 702/844
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
                
                let imageOffset = screenHeight + 36
                
                ZStack(alignment: .top) {
                    Color.background
                        .ignoresSafeArea(.all)
                    
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea(.all)
                        .offset(y: -bottomSheetTranslationProrated*imageOffset)
                    
                    Image("House")
                        .padding(.top, 257)
                        .offset(y: -bottomSheetTranslationProrated*imageOffset)
                    
                    VStack(spacing: 0) {
                        Text("Montreal")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                            if !isOpen {
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
                            } else {
                                HStack(spacing: 10) {
                                    Text("28°")
                                    Text(" | ")
                                    Text("Mostly Clear")
                                }
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray.opacity(0.8))
                            }

                        
                        Text("H:28°   L:18°")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .opacity(1-bottomSheetTranslationProrated)
                        
                    }
                    .padding(.top, 51)
                    .offset(y: -bottomSheetTranslationProrated*46)
                    
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrated.formatted())
                    } content: {
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated) // remove the is open var
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
                        .offset(y: bottomSheetTranslationProrated*150)
                    
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
