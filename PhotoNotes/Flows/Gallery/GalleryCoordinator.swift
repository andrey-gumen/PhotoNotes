import Combine
import CoreData
import SwiftUI

final class GalleryCoordinator: Coordinator {

    let id = UUID()
    
    private let persistenceController: PersistenceController
    private let cancellables: Set<AnyCancellable> = []

    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func start() -> some View {
        let viewModel = GalleryViewModel(persistenceController)
        return GalleryView(viewModel: viewModel)
    }
    
}
