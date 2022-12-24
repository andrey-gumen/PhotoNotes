import SwiftUI

protocol NavigationCoordinator: ObservableObject {
    associatedtype Body: View
    func start() -> Body
}
