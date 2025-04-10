import UIKit

import SnapKit
import Then

class DetailInfoView: BaseView {
    // MARK: - UI Components

    private let productNameLabel: UILabel = UILabel().then {
        $0.font = .fontGuide(.detailModalItemTitle)
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
    }

    private let productPriceLabel: UILabel = UILabel().then {
        $0.font = .fontGuide(.detailModalItemPrice)
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
    }

    private let minusButton = UIButton().then {
        $0.setImage(
            UITraitCollection.current.userInterfaceStyle == .light ?
            ImageLiterals.iCon.remove_circle_black_ic:
                ImageLiterals.iCon.remove_circle_white_ic,
            for: .normal
        )
        $0.titleLabel?.font = .fontGuide(.detailModalSteppers)
    }

    private let plusButton = UIButton().then {
        $0.setImage(
            UITraitCollection.current.userInterfaceStyle == .light ?
            ImageLiterals.iCon.add_circle_black_ic:
                ImageLiterals.iCon.add_circle_white_ic,
            for: .normal
        )
        $0.titleLabel?.font = .fontGuide(.detailModalSteppers)
    }

    private let quantityLabel = UILabel().then {
        $0.font = .fontGuide(.detailModalQuantity)
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
        $0.textAlignment = .center
    }

    // MARK: - Properties

    weak var delegate: DetailInfoViewDelegate?

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // 이전과 현재 모드가 다를 때만 이미지 갱신
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            minusButton.setImage(traitCollection.userInterfaceStyle == .light ?
                ImageLiterals.iCon.remove_circle_black_ic:
                    ImageLiterals.iCon.remove_circle_white_ic, for: .normal)
            
            plusButton.setImage(traitCollection.userInterfaceStyle == .light ?
                ImageLiterals.iCon.add_circle_black_ic:
                    ImageLiterals.iCon.add_circle_white_ic, for: .normal)
        }
    }

    override func setStyles() {
        backgroundColor = .clear
    }

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

    public func updateContents(productName: String, productPrice: Int, quantity: Int) {
        self.productNameLabel.text = productName
        self.productPriceLabel.text = "₩\(productPrice.formattedPrice)"
        self.quantityLabel.text = "\(quantity)"
    }

}

