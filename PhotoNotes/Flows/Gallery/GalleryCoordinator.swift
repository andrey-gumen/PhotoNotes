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
        
        viewModel.outputs.addNoteSubject
            .sink { [weak self] in self?.showAddNoteScreen() }
            .store(in: &cancellables)
        
        present(content)
    }
    
    private func showAddNoteScreen() {
        print(#function)
    }
    
    private func showDetailNoteScreen(note: PhotoNote) {
        let viewModel = DetailNoteViewModel(persistenceController, note)
        let content = DetailNoteView(viewModel: viewModel)
        
        present(content)
    }
    
    // MARK: helpers
    
    private func present(_ content: some View) {
        let view = UIHostingController(rootView: content)
        navigationController.pushViewController(view, animated: true)
    }
    
}
