import Combine
import CoreData
import SwiftUI

final class AppCoordinator: ObservableObject {

    @Published var managedContext: NSManagedObjectContext
    
    private let coordinators: [AnyObject] = []
    private let cancellables: Set<AnyCancellable> = []
    
    init(_ managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func start() -> some View {
        showGalleryFlow()
    }
    
    private func showGalleryFlow() -> some View {
        return ContentView()
            .environment(\.managedObjectContext, managedContext)
    }

}
