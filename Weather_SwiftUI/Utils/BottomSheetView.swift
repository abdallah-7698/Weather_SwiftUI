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
    private var onDrag: ((CGFloat) -> Void)?

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat = UIScreen.main.bounds.height*0.93, minHeight: CGFloat = UIScreen.main.bounds.height*0.38, onDrag: ((CGFloat) -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        self.onDrag = onDrag
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
                            self.onDrag?(value.translation.height) // call if exists
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
//
//private struct ButtonSheetDragModifier: ViewModifier {
//    var onDrag: (CGFloat) -> Void
//
//    @GestureState private var dragOffset: CGFloat = 0
//
//    func body(content: Content) -> some View {
//        content
//            .offset(y: dragOffset)
//            .gesture(
//                DragGesture()
//                    .updating($dragOffset) { value, state, _ in
//                        state = value.translation.height
//                        onDrag(value.translation.height)
//                    }
//            )
//    }
//}
//
//extension BottomSheetView {
//    func onButtonSheetDrag(_ onDrag: @escaping (CGFloat) -> Void) -> some View {
//        self.modifier(ButtonSheetDragModifier(onDrag: onDrag))
//    }
//}
