import SwiftUI

struct DetailNoteView: View {
    @StateObject var viewModel: DetailNoteViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: viewModel.note?.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                if viewModel.note?.imageUrl != nil {
                    ProgressView()
                }
            }
            ZStack(alignment: .topLeading) {
                Color.gray
                    .opacity(0.2)
                Text(viewModel.note?.note ?? "")
                    .font(.title)
                    .foregroundColor(ColorScheme.viewForeground)
                    .padding()
            }
            .cornerRadius(12)
            .padding()
        }
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
            let note = PhotoNote(date: Date.now, imageUrl: url, note: "Text message")
            let viewModel = DetailNoteViewModel(PersistenceController.preview, note)
            DetailNoteView(viewModel: viewModel)
        }
    }
}
