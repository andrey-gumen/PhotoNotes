import SwiftUI

final class AppCoordinator: ObservableObject {

    private var persistenceController: PersistenceController
    private let navigationController: UINavigationController
    private var coordinators: [AnyObject] = []
    
    init(_ persistenceController: PersistenceController, navigationController: UINavigationController) {
        self.persistenceController = persistenceController
        self.navigationController = navigationController
    }
    
    func start() {
        let coordinator = GalleryCoordinator(persistenceController, navigationController)
        coordinator.start()
        coordinators.append(coordinator)
    }
    
}
