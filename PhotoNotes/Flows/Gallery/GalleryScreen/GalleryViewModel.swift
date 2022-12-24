import Combine
import Foundation

final class GalleryViewModel: ObservableObject {
    
    @Published var notes: [PhotoNote] = []
    @Published var noNotes: Bool = true
    
    let inputs = Inputs()
    var outputs = Outputs()
    
    private let persistenceController: PersistenceController
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        inputs.becameActiveSubject
            .sink { [weak self] in self?.reloadData() }
            .store(in: &cancellables)
        
        outputs.deleteNoteSubject
            .sink { [weak self] index in self?.deleteNote(index) }
            .store(in: &cancellables)
    }
    
    private func reloadData() {
        let result = persistenceController.getNotes()
        switch result {
        case .success(let notes):
            self.notes = notes
            self.noNotes = notes.count == 0
        case .failure(let error):
            print(error)
        }
    }
    
    private func deleteNote(_ index: Int) {
        let result = persistenceController.delete(offset: index)
        
        switch result {
        case .success: reloadData()
        case .failure(let error):print(error)
        }
    }
    
    // MARK: Inputs / Outputs types
    
    struct Inputs {
        let becameActiveSubject = PassthroughSubject<Void, Never>()
    }
    
    struct Outputs {
        let addNoteSubject = PassthroughSubject<Void, Never>()
        let deleteNoteSubject = PassthroughSubject<Int, Never>()
        let showNoteSubject = PassthroughSubject<PhotoNote?, Never>()
    }
}
