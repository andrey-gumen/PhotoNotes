import SwiftUI

protocol Coordinator: Identifiable, Hashable, AnyObject {
    associatedtype Body: View
    func start() -> Body
    //var body: Body { get }
}

extension Coordinator {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
