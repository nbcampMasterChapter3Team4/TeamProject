import UIKit

import SnapKit
import Then

class DetailInfoView: BaseView {
    // MARK: - UI Components

    private let productNameLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    private let productPriceLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }

    private let minusButton = UIButton().then {
        $0.setImage(.removeCircleBlackIc, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private let plusButton = UIButton().then {
        $0.setImage(.addCircleBlackIc, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private let quantityLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .center
    }

    // MARK: - Properties

    weak var delegate: DetailInfoViewDelegate?

    override func setLayout() {
        addSubviews(productNameLabel, productPriceLabel, minusButton, quantityLabel, plusButton)

        productNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        plusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(24)
        }

        quantityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(plusButton.snp.left).offset(-8)
            $0.width.equalTo(24)
        }

        minusButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(quantityLabel.snp.left).offset(-8)
            $0.width.height.equalTo(24)
        }

        productPriceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)

    }

    // MARK: - @objc

    @objc private func didTapMinus() {
        delegate?.detailInfoViewDidTapMinus(self)
    }

    @objc private func didTapPlus() {
        delegate?.detailInfoViewDidTapPlus(self)
    }

    // MARK: - Method

    public func updateContents(productName: String, productPrice: String, quantity: Int) {
        self.productNameLabel.text = productName
        self.productPriceLabel.text = productPrice
        self.quantityLabel.text = "\(quantity)"
    }

}

