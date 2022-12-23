import Combine
import Foundation

final class GalleryViewModel: ObservableObject {
    
    @Published var notes: [PhotoNote] = []
    let inputs = Inputs()
    let outputs = Outputs()
    
    private let persistenceController: PersistenceController
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        inputs.reloadDataSubject
            .sink { [weak self] in self?.reloadData() }
            .store(in: &cancellables)
        
        outputs.addNoteSubject
            .sink { [weak self] in self?.addNote() }
            .store(in: &cancellables)
        
        outputs.deleteNotesSubject
            .sink { [weak self] offsets in self?.deleteNotes(offsets: offsets) }
            .store(in: &cancellables)
    }
    
    private func reloadData() {
        let result = persistenceController.getNotes()
        switch result {
        case .success(let notes):
            self.notes = notes
        case .failure(let error):
            print(error)
        }
    }
    
    private func addNote() {
        let note = PhotoNote(date: Date.now)
        let result = persistenceController.add(note: note)
        
        switch result {
        case .success: reloadData()
        case .failure(let error):print(error)
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        let result = persistenceController.delete(offsets: offsets)
        
        switch result {
        case .success: reloadData()
        case .failure(let error):print(error)
        }
    }
    
    // MARK: Inputs / Outputs types
    
    struct Inputs {
        let reloadDataSubject = PassthroughSubject<Void, Never>()
    }
    
    struct Outputs {
        let addNoteSubject = PassthroughSubject<Void, Never>()
        let deleteNotesSubject = PassthroughSubject<IndexSet, Never>()
        let showNoteSubject = PassthroughSubject<PhotoNote?, Never>()
    }
}
