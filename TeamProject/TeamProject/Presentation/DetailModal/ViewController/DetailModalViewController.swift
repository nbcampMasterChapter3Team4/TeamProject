import UIKit

import SnapKit
import Then

class DetailModalViewController: BaseViewController {

    // MARK: - Properties

    var detailData: IEProduct?
    var selectedColor: IEColor? {
        didSet {
            updateUI()
        }
    }

    private var currentValue: Int = 1 {
        didSet {
            updateUI()
        }
    }

    // MARK: - UI Components

    private lazy var viewControllerName = self.className
    private let detailView = DetailModalView()

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(
            name: NSNotification.Name("ModalDismissNC"),
            object: nil,
            userInfo: nil
        )
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
        detailView.detailInfoView.delegate = self
        detailView.delegate = self
    }

    func updateUI() {
        guard let detailData = detailData, let selectedColor = selectedColor else {
            return
        }
        detailView.detailImageView.updateContent(with: matchDetailProductImage(with: detailData, selectedColor: selectedColor))
        detailView.detailInfoView.updateContents(productName: detailData.name,
                                                 productPrice: detailData.price,
                                                 quantity: currentValue)
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

extension DetailModalViewController: DetailModalViewDelegate {
    func detailModalViewDidTapCart(_ detailModalView: DetailModalView) {
        guard let product = detailData else { return }
        let needToSaveData = IECartModel(
            id: UUID(),
            productID: product.id,
            selectedColor: selectedColor ?? .aquamarine,
            cartQuantity: currentValue
        )
        CoreDataManager.saveData(needToSaveData)

        let shoppingCart = CoreDataManager.fetchData()
        /// 저장 효과 주기 위해 잠시 딜레이 추가
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: true) {
                print("DetailModalView 닫힘, \(shoppingCart)")
            }
        }
        
    }
}
