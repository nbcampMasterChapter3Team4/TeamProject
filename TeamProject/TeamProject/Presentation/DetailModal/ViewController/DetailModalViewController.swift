import UIKit

import SnapKit
import Then

class DetailModalViewController: UIViewController {

    // MARK: - UI Components

    private lazy var viewControllerName = self.className
    private let detailView = DetailModalView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
        setLayout()
        setDelegates()
        setRegister()
    }

    /// View 의 Style 을 set 합니다.
    func setStyles() {
    }
    /// View 의 Layout 을 set 합니다.
    func setLayout() {
        view.addSubviews(detailView)

        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    /// View 의 Delegate 을 set 합니다.
    func setDelegates() {}
    /// View 의 Register 를 set 합니다.
    func setRegister() {}

    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}

