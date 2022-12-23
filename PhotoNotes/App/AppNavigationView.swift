import SwiftUI
import Combine

struct AppNavigationView: View {

    @ObservedObject var rootCoordinator: AppCoordinator
    
    var body: some View {
        let coordinator = GalleryCoordinator(rootCoordinator.managedContext)
        coordinator.start()
    }

}
