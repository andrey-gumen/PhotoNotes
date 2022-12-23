import Combine
import CoreData
import SwiftUI

final class AppCoordinator: ObservableObject {

    @Published var managedContext: NSManagedObjectContext
    //@Published var coordinators: [any Coordinator] = []
    
    private let cancellables: Set<AnyCancellable> = []
    
    init(_ managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
        
        activateGalleryFlow()
    }
    
    private func activateGalleryFlow() {
        //let coordinator = GalleryCoordinator(managedContext)
        //coordinators.append(coordinator)
    }

}
