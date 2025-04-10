import UIKit

import SnapKit
import Then

let mockUpData: IEProduct = IEProduct(
    id: 0,
    name: "MacBook Air 13 및 15",
    imageName: "MacBookAir",
    price: 1590000,
    description: "어디서든 일하고, 즐기고, 창작할 수 있도록 해주는 놀랍도록 얇고 빠른 노트북.",
    colors: [.midnight, .silver, .skyBlue, .starlight],
    category: .mac
)

class DetailModalView: UIView {
    
    // MARK: - UI Components

    private lazy var viewName = self.className
    var detailImageView = DetailImageView()
    var detailColorsStackView = DetailColorsStackView()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        print("🧵 \(viewName) has been successfully Removed")
    }

    /// View의 Style을 set 합니다.
    func setStyles() {
        self.backgroundColor = .white200
    }

    // MARK: - Layout Helper
    /// View 의 Layout 을 set 합니다.

    func setLayout() {
        addSubviews(detailImageView, detailColorsStackView)

        detailImageView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(13)
            $0.top.equalToSuperview().inset(33)
            $0.height.equalTo(367)
        }

        detailColorsStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(detailImageView.snp.bottom).offset(13)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
