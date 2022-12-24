import Combine
import SwiftUI

final class GalleryCoordinator: NavigationCoordinator {

    private let persistenceController: PersistenceController
    private let cancellables: Set<AnyCancellable> = []

    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func start() -> some View {
        let viewModel = GalleryViewModel(persistenceController)
        return GalleryGridView(viewModel: viewModel)
    }
    
}
