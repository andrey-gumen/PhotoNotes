import SwiftUI

struct GalleryView: View {
    
    @StateObject var viewModel: GalleryViewModel
        
    var body: some View {
        List {
            ForEach(viewModel.notes) { item in
                NavigationLink {
                    Text("Item at \(item.date, formatter: Date.itemFormatter)")
                } label: {
                    Text(item.date, formatter: Date.itemFormatter)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .onAppear {
            viewModel.inputs.reloadDataSubject.send()
        }
    }

    private func addItem() {
        withAnimation {
            viewModel.outputs.addNoteSubject.send()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.outputs.deleteNotesSubject.send(offsets)
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let viewModel = GalleryViewModel(PersistenceController.preview)
            GalleryView(viewModel: viewModel)
        }
    }
}
