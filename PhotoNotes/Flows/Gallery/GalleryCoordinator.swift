import Combine
import SwiftUI

final class GalleryCoordinator: NavigationCoordinator {

    private let persistenceController: PersistenceController
    private var cancellables: Set<AnyCancellable> = []
    
    //var viewModel: GalleryViewModel?

    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        
        //viewModel = GalleryViewModel(persistenceController)
    }
    
    deinit{
        print("deinit GalleryCoordinator")
    }
    
    func start() -> some View {
        let viewModel = GalleryViewModel(persistenceController)
//        viewModel.outputs.addNoteSubject
//            .sink { [weak self] in self?.showAddNoteScreen(); print("add note") }
//            .store(in: &cancellables)
        
        viewModel.outputs.addNoteSubject
            .sink(
                receiveCompletion: { completion in
                    // Called once, when the publisher was completed.
                    print("receiveCompletion: \(completion)")
                },
                receiveValue: { value in
                    // Can be called multiple times, each time that a
                    // new value was emitted by the publisher.
                    print("receiveValue 2: \(value)")
                }
            )
            .store(in: &cancellables)
        
        return GalleryGridView(viewModel: viewModel)
    }
    
    private func showAddNoteScreen() {
        let viewModel = DetailNoteViewModel(persistenceController)
        DetailNoteView(viewModel: viewModel)
    }
    
}
