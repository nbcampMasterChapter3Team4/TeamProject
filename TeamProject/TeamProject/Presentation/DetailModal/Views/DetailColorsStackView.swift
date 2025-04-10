import UIKit
import SnapKit
import Then

class DetailColorsStackView: UIStackView {

    // MARK: - Properties

    var colorSelectedHandler: ((IEColor) -> Void)?
    private var colors: [IEColor] = []
    private var radioButtons: [CustomRadioButton] = []

    /// View의 Style 설정
    func setStyles() {
        self.axis = .horizontal
        self.spacing = 4
        self.alignment = .center
        self.distribution = .equalSpacing
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    func updateContent(with colors: [IEColor]) {
        self.colors = colors

        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        radioButtons.removeAll()

        for (index, color) in colors.enumerated() {
            let radioButton = CustomRadioButton()
            radioButton.setStyles()
            radioButton.setLayout()
            radioButton.configure(with: color)

            radioButton.getRadioButton().tag = index

            radioButton.getRadioButton().addTarget(self, action: #selector(didTapRadio(_:)), for: .touchUpInside)

            addArrangedSubview(radioButton)
            radioButtons.append(radioButton)
        }
    }

    // MARK: - @objc Methods

    @objc private func didTapRadio(_ sender: UIButton) {
        let newIndex = sender.tag

        // 모든 버튼에 대해 선택 상태 업데이트 (선택된 버튼만 true)
        for (index, button) in radioButtons.enumerated() {
            button.setSelected(index == newIndex)
        }

        // 선택된 색상을 핸들러를 통해 외부로 전달
        let selectedColor = colors[newIndex]
        colorSelectedHandler?(selectedColor)
        print("선택된 인덱스: \(newIndex), 색상: \(selectedColor)")
    }
}
