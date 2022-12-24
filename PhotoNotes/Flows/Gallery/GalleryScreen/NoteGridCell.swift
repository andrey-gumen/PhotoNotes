import SwiftUI

struct NoteGridCell: View {
    let size: Double
    let item: PhotoNote

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: item.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}

struct NoteGridCell_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
            NoteGridCell(size: 150, item: PhotoNote(date: Date.now, imageUrl: url))
        }
    }
}
