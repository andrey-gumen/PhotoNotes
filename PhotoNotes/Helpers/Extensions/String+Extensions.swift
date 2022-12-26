import Foundation

extension String {
    var isBlank: Bool {
        allSatisfy(\.isWhitespace)
    }
}
