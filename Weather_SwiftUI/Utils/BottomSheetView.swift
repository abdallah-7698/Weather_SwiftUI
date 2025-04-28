//
//  BottomSheetView.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//


import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let snapRatio: CGFloat = 0.25
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat = UIScreen.main.bounds.height*0.93, minHeight: CGFloat = UIScreen.main.bounds.height*0.38, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            self.content
                .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(self.offset + self.translation, 0))
                .animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.8), value: isOpen)
                .gesture(
                    DragGesture()
                        .updating(self.$translation) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            self.isOpen = value.translation.height < 0
                        }
                )
        }
        .edgesIgnoringSafeArea(.all)
    }

}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(isOpen: .constant(true)) {
            Rectangle().fill(Color.red)
        }
    }
}
