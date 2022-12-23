import Combine
import CoreData
import SwiftUI

final class AppCoordinator: ObservableObject {

    @Published var managedContext: NSManagedObjectContext
    @Published var coordinators: [any Coordinator] = []
    
    private let cancellables: Set<AnyCancellable> = []
    
    init(_ managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func start() -> some View {
        let coordinator = GalleryCoordinator(managedContext)
        coordinators.append(coordinator)
        return coordinator.start()
    }

}
