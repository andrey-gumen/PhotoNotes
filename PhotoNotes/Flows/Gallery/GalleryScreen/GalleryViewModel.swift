import Combine
import Foundation

final class GalleryViewModel: ObservableObject {
    
    @Published var notes: [PhotoNote] = []
    let inputs = Inputs()
    var outputs = Outputs()
    
    private let persistenceController: PersistenceController
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        inputs.reloadDataSubject
            .sink { [weak self] in self?.reloadData() }
            .store(in: &cancellables)
        
        outputs.deleteNoteSubject
            .sink { [weak self] index in self?.deleteNote(index) }
            .store(in: &cancellables)
        
        outputs.addNoteSubject
            .sink(
                receiveCompletion: { completion in
                    // Called once, when the publisher was completed.
                    print("receiveCompletion: \(completion)")
                },
                receiveValue: { value in
                    // Can be called multiple times, each time that a
                    // new value was emitted by the publisher.
                    print("receiveValue: \(value)")
                }
            )
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
    
//    private func addNote() {
//        let note = PhotoNote(date: Date.now)
//        let result = persistenceController.add(note: note)
//
//        switch result {
//        case .success: reloadData()
//        case .failure(let error):print(error)
//        }
//    }
    
    private func deleteNote(_ index: Int) {
        let result = persistenceController.delete(offset: index)
        
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
        let deleteNoteSubject = PassthroughSubject<Int, Never>()
        let showNoteSubject = PassthroughSubject<PhotoNote?, Never>()
    }
}
