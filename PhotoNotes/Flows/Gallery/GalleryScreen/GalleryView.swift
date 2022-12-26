import SwiftUI

struct GalleryView: View {

    @StateObject var viewModel: GalleryViewModel
    
    @State private var isEditing = false
    
    private static let initialColumns = 1
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns

    var body: some View {
        VStack {
            if isEditing {
                let columnsTitle = gridColumns.count > 1
                    ? "\(gridColumns.count) Columns"
                    : "1 Column"
                ColumnStepper(title: columnsTitle, range: 1 ... 8, columns: $gridColumns)
                    .padding()
            }
            PhotoNotesGridView(
                viewModel: viewModel,
                isEditing: $isEditing,
                gridColumns: $gridColumns
            )
            if viewModel.noNotes {
                Text("no notes")
                    .font(Font.callout)
                    .opacity(0.4)
            }
        }
        .navigationBarTitle("Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.outputs.addNoteSubject.send()
                } label: {
                    Image(systemName: "camera.badge.ellipsis")
                }
                .disabled(isEditing)
            }
        }
        .onAppear {
            viewModel.inputs.becameActiveSubject.send()
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let viewModel = GalleryViewModel(PersistenceController.preview)
            GalleryView(viewModel: viewModel)
        }
    }
}
