import SwiftUI

struct GalleryGridView: View {
    
    @StateObject var viewModel: GalleryViewModel

    private static let initialColumns = 1
    @State private var isAddingPhoto = false
    @State private var isEditing = false

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
            grid
        }
        .navigationBarTitle("Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPhoto) {
            PhotoPicker()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingPhoto = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }
        .onAppear {
            viewModel.inputs.reloadDataSubject.send()
        }
    }
    
    private var grid: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach(viewModel.notes) { note in
                    GeometryReader { geo in
                        NavigationLink {
                            DetailNoteView(item: note)
                        } label: {
                            NoteGridCell(size: geo.size.width, item: note)
                        }
                    }
                    .cornerRadius(8.0)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(alignment: .topTrailing) {
                        if isEditing {
                            Button {
                                withAnimation {
                                    //dataModel.removeItem(item)
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

struct GalleryGridView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GalleryViewModel(PersistenceController.preview)
        GalleryGridView(viewModel: viewModel)
    }
}
