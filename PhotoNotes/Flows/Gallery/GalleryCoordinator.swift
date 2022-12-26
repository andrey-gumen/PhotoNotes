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
    
    func start() {
        let viewModel = GalleryViewModel(persistenceController)
        viewModel.inputs.addNoteSubject
            .sink { [weak self] in self?.showAddNoteScreen() }
            .store(in: &cancellables)
        
        let content = GalleryView(viewModel: viewModel)
        present(content)
    }
    
    private func showAddNoteScreen() {
        let note = PhotoNote(date: Date.now)
        showPickImageScreen(for: note)
    }
    
    private func showPickImageScreen(for note: PhotoNote) {
        // show image picker
        // and then show detail note screen to specify data
        let sourceType = UIDevice.isSimulator
            ? UIImagePickerController.SourceType.photoLibrary
            : UIImagePickerController.SourceType.camera
        let content = ImagePicker(sourceType: sourceType)
        content.selectedImageUrlsubject
            .sink { [weak self] url in
                var changed = note
                changed.imageUrl = url
                self?.showDetailNoteScreen(for: changed)
            }.store(in: &cancellables)
        present(content, transition: .fullScreen)
    }
    
    private func showDetailNoteScreen(for note: PhotoNote) {
        let viewModel = DetailNoteViewModel(persistenceController, note)
        viewModel.outputs.pickImageSubject
            .sink { [weak self] in
                self?.popView()
                self?.showPickImageScreen(for: viewModel.note)
            }.store(in: &cancellables)
        
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
    
    private func popView(animated: Bool = false) {
        navigationController.popViewController(animated: animated)
    }
    
}
