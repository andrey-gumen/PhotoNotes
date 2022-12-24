import SwiftUI

final class AppCoordinator: ObservableObject {

    @Published var persistenceController: PersistenceController
    private var coordinators: [any NavigationCoordinator] = []
    
    init(_ persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        activateGalleryFlow()
    }
    
    private func activateGalleryFlow() {
        let coordinator = GalleryCoordinator(persistenceController)
        coordinators.append(coordinator)
        return coordinator.start()
    }

}
