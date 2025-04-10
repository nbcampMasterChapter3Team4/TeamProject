import UIKit

import SnapKit
import Then

class DetailImageView: BaseView {

    private lazy var viewName = self.className

    // MARK: - UI Components

    private let productImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Initializer

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
    override func setStyles() {
        backgroundColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .gray100
            } else {
                return .gray700
            }
        }
            
        self.layer.cornerRadius = 10
    }

    // MARK: - Layout Helper
    /// View 의 Layout 을 set 합니다.

    override func setLayout() {
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

    // MARK: - Methods
    
    func updateContent(with imageName: String) {
        self.productImageView.image = UIImage(named: imageName)
        print(imageName)
    }
}
