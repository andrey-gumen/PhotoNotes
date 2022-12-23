import SwiftUI

@main
struct PhotoNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            let rootCoordinator = AppCoordinator(persistenceController.container.viewContext)
//            NavigationView(coordinator: rootCoordinator)
        }
    }
}
