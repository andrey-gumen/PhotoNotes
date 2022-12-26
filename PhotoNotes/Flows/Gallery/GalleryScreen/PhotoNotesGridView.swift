import SwiftUI

struct PhotoNotesGridView: View {

    @StateObject var viewModel: GalleryViewModel

    @Binding var isEditing: Bool
    @Binding var gridColumns: [GridItem]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(Array(viewModel.notes.enumerated()), id: \.offset) { index, note in
                    GeometryReader { geo in
                        Button {
                            viewModel.inputs.showNoteSubject.send(note)
                        } label: {
                            NoteGridCell(size: geo.size.width, item: note)
                        }
                        .disabled(isEditing)
                    }
                    .cornerRadius(8.0)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(alignment: .topTrailing) {
                        if isEditing {
                            Button {
                                withAnimation {
                                    viewModel.inputs.deleteNoteSubject.send(index)
                                }
                            } label: {
                                let font = gridColumns.count >= 3 ? Font.title3
                                    : gridColumns.count == 2 ? Font.title2
                                    : Font.title
                                Image(systemName: "minus.circle.fill")
                                    .font(font)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, .red)
                            }
                            .offset(x: 7, y: -7)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct PhotoNotesGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let viewModel = GalleryViewModel(PersistenceController.preview)
            let columns = Array(repeating: GridItem(.flexible()), count: 1)
            PhotoNotesGridView(
                viewModel: viewModel,
                isEditing: .constant(false),
                gridColumns: .constant(columns)
            )
            .navigationBarTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
