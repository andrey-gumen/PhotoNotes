import Combine
import Foundation
import UIKit

final class DetailNoteViewModel: ObservableObject {
    
    @Published var note: PhotoNote
    let inputs = Inputs()
    
    private let persistenceController: PersistenceController
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ persistenceController: PersistenceController, _ note: PhotoNote) {
        self.persistenceController = persistenceController
        self.note = note
       
        inputs.saveNoteSubject
            .sink { [weak self] in self?.saveNote() }
            .store(in: &cancellables)
    }
    
    private func saveNote() {
        let result = persistenceController.add(note: note)
        
        switch result {
        case .success: break
        case .failure(let error): print(error)
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        let result = persistenceController.delete(offsets: offsets)
        
        switch result {
        case .success: break
        case .failure(let error): print(error)
        }
    }
    
    // MARK: Outputs types
    
    struct Inputs {
        let saveNoteSubject = PassthroughSubject<Void, Never>()
        let pickImageSubject = PassthroughSubject<Void, Never>()
        let deleteSubject = PassthroughSubject<PhotoNote, Never>()
    }
}

