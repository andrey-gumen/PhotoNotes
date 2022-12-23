import SwiftUI
import Combine

struct NavigationView: View {

    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
//        NavigationStack {
//            VStack() {
//                //let currentCoordinator = coordinator.$coordinators
//            }
//            .navigationDestination(for: Coordinator.self) { _ in
//                //$0.start()
//            }
//        }
        Text("Test")
    }

}
