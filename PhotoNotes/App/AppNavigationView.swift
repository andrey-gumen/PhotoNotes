import SwiftUI
import Combine

struct AppNavigationView: View {

    @ObservedObject var rootCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            VStack() {
                //let currentCoordinator: GalleryCoordinator? = GalleryCoordinator(rootCoordinator.managedContext)
                
                //let currentCoordinator = rootCoordinator.coordinators?.last
                //currentCoordinator?.body ?? EmptyView
//                if let currentCoordinator = rootCoordinator.coordinators.last {
//                    currentCoordinator.start()
//                } else {
//                    EmptyView()
//                }
            }
//            .navigationDestination(for: Coordinator) {
//                $0.start()
//            }
        }
        
    }

}
