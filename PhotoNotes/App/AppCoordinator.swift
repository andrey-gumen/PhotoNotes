import CoreData
import SwiftUI

final class AppCoordinator: ObservableObject {

    @Published var managedContext: NSManagedObjectContext
    private var coordinators: [any Coordinator] = []
    
    init(_ managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
        activateGalleryFlow()
    }
    
    private func activateGalleryFlow() {
        let coordinator = GalleryCoordinator(managedContext)
        coordinators.append(coordinator)
    }

}
