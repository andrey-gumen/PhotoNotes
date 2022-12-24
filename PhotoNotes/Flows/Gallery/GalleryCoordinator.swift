import Combine
import _PhotosUI_SwiftUI
import SwiftUI
import UIKit

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
        let content = PhotoPicker()
        present(content, transition: .sheet)
    }
    
    private func showDetailNoteScreen(note: PhotoNote) {
        let viewModel = DetailNoteViewModel(persistenceController, note)
        let content = DetailNoteView(viewModel: viewModel)
        
        present(content)
    }
    
    // MARK: helpers
    
    private enum NavigationTranisitionStyle {
        case push
        case sheet
        case fullScreen
    }
    
    private func present(_ content: some View, transition: NavigationTranisitionStyle = .push, animated: Bool = true, completion: (() -> Void)? = nil) {
        let viewController = UIHostingController(rootView: content)
        switch transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .sheet:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated, completion: completion)
        case .fullScreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated, completion: completion)
        }
    }
    
}
