import Combine
import SwiftUI

final class GalleryCoordinator {
    
    private let persistenceController: PersistenceController
    private let navigationController: UINavigationController
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ persistenceController: PersistenceController, _ navigationController: UINavigationController) {
        self.persistenceController = persistenceController
        self.navigationController = navigationController
    }
    
    deinit{
        print("deinit GalleryCoordinator")
    }
    
    func start() {
        let viewModel = GalleryViewModel(persistenceController)
        let content = GalleryGridView(viewModel: viewModel)
        
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
        
        present(content)
    }
    
    private func present(_ content: some View) {
        let view = UIHostingController(rootView: content)
        navigationController.pushViewController(view, animated: true)
    }
    
    private func showAddNoteScreen() {
//        let viewModel = DetailNoteViewModel(persistenceController)
//        DetailNoteView(viewModel: viewModel)
    }
    
}
