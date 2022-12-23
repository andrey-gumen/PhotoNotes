import SwiftUI
import Combine

struct AppNavigationView: View {

    @StateObject var rootCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            let coordinator = GalleryCoordinator(rootCoordinator.persistenceController)
            coordinator.start()
        }
        .navigationViewStyle(.stack)
    }

}

struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        let rootCoordinator =  AppCoordinator(PersistenceController.preview)
        AppNavigationView(rootCoordinator: rootCoordinator)
    }
}
