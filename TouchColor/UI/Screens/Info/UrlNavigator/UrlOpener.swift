import Foundation
import UIKit

protocol UrlOpening {
    func open(url: URL) -> Bool
    func canOpen(url: URL?) -> Bool
}

class UrlOpener: UrlOpening {

    func open(url: URL) -> Bool {
        guard UIApplication.shared.canOpenURL(url) else { return false }
        return UIApplication.shared.openURL(url)
    }

    func canOpen(url: URL?) -> Bool {
        guard let url = url else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

}
