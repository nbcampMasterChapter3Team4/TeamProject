import UIKit

import SnapKit
import Then

class DetailColorsStackView: UIStackView {

    // MARK: - Properties

    var colorSelectedHandler: ((IEColor) -> Void)?
    private var colors: [IEColor] = []

    /// View 의 Style 을 set 합니다.
    func setStyles() {
        self.axis = .horizontal
        self.spacing = 8
        self.alignment = .center
        self.distribution = .equalSpacing
    }

    // MARK: - Methods
    
    func updateContent(with colors: [IEColor]) {
        self.colors = colors

        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for color in colors {
            let colorButton = UIButton(type: .system)
            colorButton.layer.cornerRadius = 16
            colorButton.clipsToBounds = true
            colorButton.backgroundColor = color.colorValue
            colorButton.tag = color.hashValue
            colorButton.snp.makeConstraints {
                $0.width.height.equalTo(32)
            }

            colorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)

            addArrangedSubview(colorButton)
        }
    }

    // MARK: - @objc Methods

    @objc private func colorButtonTapped(_ sender: UIButton) {
        guard let selectedColor = colors.first(where: { $0.hashValue == sender.tag }) else {
            return
        }
        colorSelectedHandler?(selectedColor)
    }
}
