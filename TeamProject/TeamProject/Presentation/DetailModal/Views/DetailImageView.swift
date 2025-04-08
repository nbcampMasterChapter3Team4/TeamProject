import UIKit

import SnapKit
import Then

class DetailImageView: UIView {

    private lazy var viewName = self.className

    // MARK: - UI Components

    private let productImageView = UIImageView().then {
        $0.image = ImageLiterals.Detail.macBookAir_Silver
        $0.contentMode = .scaleAspectFit
    }


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
    func setStyles() {
        backgroundColor = .gray100
        self.layer.cornerRadius = 10
    }
    /// View 의 Layout 을 set 합니다.
    func setLayout() {
        addSubviews(productImageView)

        productImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
