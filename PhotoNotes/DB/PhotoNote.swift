import Foundation
import SwiftUI

struct PhotoNote: Identifiable {
    let id: UUID = UUID()
    
    // MARK: required properties
    var date: Date
    
    // MARK: optional properties
    var imageUrl: URL?
    var image: UIImage?
    var note: String?
}
