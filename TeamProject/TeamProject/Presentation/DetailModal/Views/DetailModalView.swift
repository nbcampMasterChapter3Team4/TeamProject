import UIKit

import SnapKit
import Then

class DetailModalView: UIView {

    private lazy var viewName = self.className

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("🧵 \(viewName) has been successfully Removed")
    }

    /// View 의 Layout 을 set 합니다.
    func setLayout() {
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
