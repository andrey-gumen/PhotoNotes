import SwiftUI
import Combine

struct AppNavigationView: View {

    @StateObject var rootCoordinator: AppCoordinator
    
    var body: some View {
        NavigationView {
            let coordinator = GalleryCoordinator(rootCoordinator.persistenceController)
            coordinator.start()
        }
    }

}
