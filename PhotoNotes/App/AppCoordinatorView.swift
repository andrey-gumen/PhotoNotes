import SwiftUI
import Combine

struct AppCoordinatorView: View {

    @ObservedObject var object: AppCoordinator
    
    var body: some View {
        ContentView()
            .environment(\.managedObjectContext, object.managedContext)
    }

}
