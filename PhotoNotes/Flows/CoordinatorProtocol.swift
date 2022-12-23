import SwiftUI

protocol Coordinator: Identifiable, Hashable {
    func start() -> any View
}

extension Coordinator {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
