import Combine
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
        // show image picker
        // and then show detail note screen to specify data
        let sourceType = UIDevice.isSimulator
            ? UIImagePickerController.SourceType.photoLibrary
            : UIImagePickerController.SourceType.camera
        let content = ImagePicker(sourceType: sourceType)
        content.selectedImageUrlsubject
            .sink { [weak self] url in self?.showDetailNoteScreen(imageUrl: url) }
            .store(in: &cancellables)
        present(content, transition: .fullScreen)
    }
    
    private func showDetailNoteScreen(imageUrl: URL?) {
        let note = PhotoNote(date: Date.now, imageUrl: imageUrl)
        showDetailNoteScreen(note: note)
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
