import SwiftUI

struct DetailNoteView: View {
    let item: PhotoNote

    var body: some View {
        AsyncImage(url: item.imageUrl) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
            DetailNoteView(item: PhotoNote(date: Date.now, imageUrl: url))
        }
    }
}
