import SwiftUI

@main
struct PhotoNotesApp: App {    
    @StateObject var rootCoordinator = AppCoordinator(PersistenceController.shared)

    var body: some Scene {
        WindowGroup {
            AppNavigationView(rootCoordinator: rootCoordinator)
        }
    }
}
