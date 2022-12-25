import SwiftUI

struct TextEditorWithPlaceHolder: View {
    var placeHolder: String = "Write something..."
    
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
                    .opacity(0.4)
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
            Color.gray
                .ignoresSafeArea()
            TextEditorWithPlaceHolder(placeHolder: "Preview placeholder", text: .constant(""))
                .padding()
                .foregroundColor(.blue)
                .font(.title)
        }
    }
}
