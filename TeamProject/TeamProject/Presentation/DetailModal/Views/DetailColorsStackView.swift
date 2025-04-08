import UIKit

import SnapKit
import Then

class DetailColorsStackView: UIStackView {

    private lazy var viewName = self.className

    // MARK: - UI Components
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("🧵 \(viewName) has been successfully Removed")
    }

    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayout() {}

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
