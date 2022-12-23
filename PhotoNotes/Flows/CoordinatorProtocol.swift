import SwiftUI

protocol NavigationCoordinator: Identifiable, Hashable, ObservableObject {
    associatedtype Body: View
    func start() -> Body
}

extension NavigationCoordinator {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
