import SwiftUI
import Combine

struct AppNavigationView: View {

    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            Text("Test")
//            VStack() {
//                //let currentCoordinator = coordinator.$coordinators
//            }
//            .navigationDestination(for: Coordinator.self) { _ in
//                //$0.start()
//            }
        }
        
    }

}
