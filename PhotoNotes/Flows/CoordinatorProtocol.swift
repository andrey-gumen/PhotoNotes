import SwiftUI

protocol Coordinator: Identifiable, Hashable, ObservableObject {
    associatedtype Body: View
    func start() -> Body
}

extension Coordinator {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
