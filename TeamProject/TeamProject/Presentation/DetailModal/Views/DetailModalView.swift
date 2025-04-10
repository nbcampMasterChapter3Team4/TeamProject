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

class DetailModalView: BaseView {

    // MARK: - UI Components

    private lazy var viewName = self.className
    var detailImageView = DetailImageView()
    var detailColorsStackView = DetailColorsStackView()
    var detailInfoView = DetailInfoView()

    private let cartButton: UIButton = UIButton().then {
        $0.setTitle("장바구니", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue200
        $0.layer.cornerRadius = 20
    }

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
    override func setStyles() {
        self.backgroundColor = .white200
    }

    // MARK: - Layout Helper
    /// View 의 Layout 을 set 합니다.

    override func setLayout() {
        addSubviews(detailImageView, detailColorsStackView, detailInfoView, cartButton)

        detailImageView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(13)
            $0.top.equalToSuperview().inset(33)
            $0.height.equalTo(367)
        }

        detailColorsStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(detailImageView.snp.bottom).offset(13)
        }

        detailInfoView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(13)
            $0.top.equalTo(detailColorsStackView.snp.bottom).offset(28)
            $0.height.equalTo(40)
        }

        cartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(49)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(detailInfoView.snp.bottom).offset(23)
            $0.height.equalTo(44)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
