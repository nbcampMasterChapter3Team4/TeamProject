import UIKit

import SnapKit
import Then

let mockUpData: IEProduct = IEProduct(
    id: UUID(),
    name: "MacBook Air 13 및 15",
    imageName: "MacBookAir",
    price: 1590000,
    description: "어디서든 일하고, 즐기고, 창작할 수 있도록 해주는 놀랍도록 얇고 빠른 노트북.",
    colors: [.midnight, .silver, .skyBlue, .starlight],
    category: .mac
)

class DetailModalView: UIView {
    var detailData: IEProduct? {
        didSet {
            updateUI()
        }
    }

    var selectedColor: IEColor? {
        didSet {
            updateUI()
        }
    }

    // MARK: - UI Components

    private lazy var viewName = self.className
    private var detailImageView = DetailImageView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setStyles()

        // TODO: - 메인뷰컨에서 불러와야 함

        updateContent(with: mockUpData)
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
        addSubviews(detailImageView)

        detailImageView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(13)
            $0.top.equalToSuperview().inset(33)
            $0.height.equalTo(367)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func detailImage(for product: IEProduct) -> String {
        let imageName = "\(product.imageName)_\(selectedColor?.rawValue ?? "Silver")"
        return imageName
    }

    func updateContent(with product: IEProduct) {
        self.detailData = product
    }

    private func updateUI() {
        guard let product = detailData else { return }
        detailImageView.updateContent(with: detailImage(for: product))
    }
}
