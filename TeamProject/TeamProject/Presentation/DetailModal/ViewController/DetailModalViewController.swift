import UIKit

import SnapKit
import Then

class DetailModalViewController: BaseViewController {

    // MARK: - Properties

    var detailData: IEProduct? = mockUpData
    var selectedColor: IEColor? {
        didSet {
            updateUI()
        }
    }

    private var currentValue: Int = 1 {
        didSet {
            updateInfoView()
        }
    }

    // MARK: - UI Components

    private lazy var viewControllerName = self.className
    private let detailView = DetailModalView()
    private let colorsStackView = DetailColorsStackView()
    private let detailInfoView = DetailInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstColor = detailData?.colors.first {
            selectedColor = firstColor
        } else {
            selectedColor = .silver
        }
        setStyles()
        setLayout()
        updateUI()
        setDelegates()
        setRegister()
        updateInfoView()
        setupColorsStackView()
    }

    // MARK: - Layout Helper

    override func setLayout() {
        view.addSubviews(detailView)

        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    override func setDelegates() {
        detailInfoView.delegate = self
    }

    func updateUI() {
        guard let detailData = detailData, let selectedColor = selectedColor else {
            return
        }
        detailView.detailImageView.updateContent(with: matchDetailProductImage(with: mockUpData, selectedColor: selectedColor))
        detailView.detailColorsStackView.updateContent(with: detailData.colors)
    }

    func matchDetailProductImage(with product: IEProduct, selectedColor: IEColor) -> String {
        let imageName = "\(product.imageName)_\(selectedColor.rawValue)"
        return imageName
    }

    private func setupColorsStackView() {
        let availableColors: [IEColor] = detailData?.colors ?? [.silver]
        detailView.detailColorsStackView.updateContent(with: availableColors)
        detailView.detailColorsStackView.updateContent(with: availableColors)
        detailView.detailColorsStackView.colorSelectedHandler = { [weak self] newColor in
            self?.selectedColor = newColor
        }
    }

    private func updateInfoView() {
        detailInfoView.updateContents(productName: detailData?.name ?? "123",
                                      productPrice: "\(detailData?.price ?? 0)",
                                      quantity: currentValue)
    }

    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}

extension DetailModalViewController: DetailInfoViewDelegate {
    func detailInfoViewDidTapMinus(_ detailInfoView: DetailInfoView) {
        guard currentValue > 0 else { return }
        currentValue -= 1
    }

    func detailInfoViewDidTapPlus(_ detailInfoView: DetailInfoView) {
        guard currentValue < 10 else { return }
        currentValue += 1
    }
}
