import Combine
import CoreData
import SwiftUI

final class GalleryCoordinator: Coordinator {

    let id = UUID()
    let managedContext: NSManagedObjectContext

    private let cancellables: Set<AnyCancellable> = []

    init(_ managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func start() -> some View {
        return body
    }
    
    var body: some View {
        ContentView()
            .environment(\.managedObjectContext, managedContext)
    }
    
}
