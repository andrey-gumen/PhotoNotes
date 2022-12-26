import SwiftUI

private struct VerticalGradient: ViewModifier {
    var height: CGFloat = 50
    
    func body(content: Content) -> some View {
        content
            .mask(
                VStack(spacing: 0) {
                    // start gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0), Color.black]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: height)

                    // Middle
                    Rectangle().fill(Color.black)

                    // end gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: height)
                }
            )
    }
}

extension ScrollView {
    
    @ViewBuilder func verticalGradient(height: CGFloat = 50) -> some View {
        self.modifier(VerticalGradient(height: height))
    }
    
}
