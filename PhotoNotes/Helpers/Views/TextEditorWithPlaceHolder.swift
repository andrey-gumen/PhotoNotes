import SwiftUI

struct TextEditorWithPlaceHolder: View {
    var placeHolder = "Write something..."

    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .focused($isFocused, equals: true)

            if text.isEmpty {
                Text(placeHolder)
                    .padding(.top, 10)
                    .padding(.leading, 6)
                    .opacity(0.8)
                    .onTapGesture {
                        self.isFocused = true
                    }
            }
        }
    }
}

struct TextEditorWithPlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            TextEditorWithPlaceHolder(placeHolder: "Preview placeholder", text: .constant(""))
                .scrollContentBackground(.hidden)
                .foregroundColor(Color.white)
                .shadow(color: .black, radius: 3)
                .font(.title.weight(.bold))
                .padding()
        }
    }
}
