//
//  NavigationBar.swift
//  Weather_SwiftUI
//
//  Created by name on 29/04/2025.
//

import SwiftUI

struct NavigationBar: View {
  
    @Environment(\.dismiss) var dismiss
    
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack {
               
                Button {
                    dismiss()
                } label: {
                    HStack (spacing: 5){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.white.opacity(0.5))
                        Text("Weather")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(height: 44)
                }

                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 28))
                    .frame(width: 44, height: 44, alignment: .trailing)
                
            }
            .foregroundColor(.white)
            .frame(height: 52)
            
            HStack(spacing: 5) {
               Image(systemName: "magnifyingglass")
                TextField("", text: $searchText, prompt: Text("Search for a city").foregroundStyle(.white.opacity(0.5)))
            }
            .foregroundStyle(.white.opacity(0.5))
            .padding(.horizontal, 6)
            .padding(.vertical, 7)
            .frame(height: 36, alignment: .leading)
            .background(Color.bottomSheetBackground, in: RoundedRectangle(cornerRadius: 10))
            .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .black.opacity(0.25), lineWidth: 2, offsetX: 0, offsetY: 2, blur: 2)
            
        }
        .frame(height: 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 64)
        .backgroundBlur(radius: 20, opaque: true)
        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    NavigationBar(searchText: .constant(""))
}
