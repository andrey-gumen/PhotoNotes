import Foundation
import SwiftUI

struct PhotoNote: Identifiable {
    // MARK: required properties
    var id: String = UUID().uuidString
    var date: Date
    
    // MARK: optional properties
    var imageUrl: URL?
    var note: String = ""
}
