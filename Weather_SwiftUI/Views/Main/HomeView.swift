//
//  HomeView.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isOpen: Bool = false
    
    var body: some View {
        NavigationView {
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
                
                ForecastView(isOpen: $isOpen)
                
                TabBar(action: {})
                
            }
        }
        
    }
}

#Preview {
    HomeView()
}
