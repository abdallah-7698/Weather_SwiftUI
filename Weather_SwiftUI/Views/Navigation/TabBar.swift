//
//  TabBar.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI

struct TabBar: View {
    var action: () -> Void
    var body: some View {
        ZStack(alignment: .bottom) {
           
            ShapeView()
                
            
            HStack{
                Button {
                    action()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                .padding(EdgeInsets(top: 20, leading: 35, bottom: 10, trailing: 35))
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .frame(width: 44, height: 44)
                        
                }
                .padding(.bottom, 15)
                .font(.system(size: 45))
                
                
                Spacer()
                
                NavigationLink {
                    WeatherView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
                .padding(EdgeInsets(top: 20, leading: 35, bottom: 10, trailing: 35))
                
            }
            .font(.title2)
            .foregroundColor(.white)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
                
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    TabBar(action: {})
        .preferredColorScheme(.dark)
}
