import Foundation
import SwiftUI

struct PhotoNote: Identifiable {
    let id: UUID = UUID()
    
    // MARK: required properties
    let date: Date
    
    // MARK: optional properties
    let image: UIImage?
    let note: String?
}
