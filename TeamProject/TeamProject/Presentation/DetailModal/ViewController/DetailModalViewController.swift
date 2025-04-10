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

    // MARK: - UI Components

    private lazy var viewControllerName = self.className
    private let detailView = DetailModalView()
    private let colorsStackView = DetailColorsStackView()

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
        detailView.detailColorsStackView.colorSelectedHandler = { [weak self] newColor in
            self?.selectedColor = newColor
        }
    }

    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}
