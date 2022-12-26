import UIKit

extension UIDevice {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
