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
        $0.setTitle("-", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }

    private let plusButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
    }

    private let quantityLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .center
    }

    // MARK: - Properties


}
