
import UIKit

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next {
            if let vc = nextResponder as? UIViewController {
                return vc
            } else {
                return nextResponder.findViewController()
            }
        }
        return nil
    }
}
