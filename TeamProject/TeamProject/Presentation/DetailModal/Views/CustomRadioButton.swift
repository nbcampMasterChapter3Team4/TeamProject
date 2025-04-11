import UIKit

import SnapKit
import Then

class CustomRadioButton: BaseView {
    
    // MARK: - UI Components
    
    private let radioButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = (SizeLiterals.Screen.screenWidth * 32 / 402) / 2
    }
    private let radioBorderView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
    }
    
    // MARK: - Properties

    private var isSelectedColor = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radioBorderView.layer.cornerRadius = radioBorderView.bounds.width / 2
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard let previous = previousTraitCollection,
              previous.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        
        if radioBorderView.layer.borderColor != UIColor.blue200.cgColor {
            let borderColor = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .black100
                } else {
                    return .white200
                }
            }
            radioBorderView.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func setStyles() {
        self.backgroundColor = .clear
    }
    
    // MARK: - Layout Helper
    
    override func setLayout() {
        addSubviews(radioBorderView)
        radioBorderView.addSubviews(radioButton)
        
        radioButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(SizeLiterals.Screen.screenWidth * 32 / 402)
        }
        
        radioBorderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(SizeLiterals.Screen.screenWidth * 40 / 402)
        }
    }
    
    // MARK: - Methods
    
    func configure(with colors: IEColor) {
        radioButton.backgroundColor = colors.colorValue
    }
    
    func setSelected(_ isSelected: Bool) {
        print(isSelected)
        if isSelected {
            radioBorderView.layer.borderColor = UIColor.blue200.cgColor
        } else {
            let borderColor = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .black100
                } else {
                    return .white200
                }
            }
            radioBorderView.layer.borderColor = borderColor.cgColor
        }
    }

    func getRadioButton() -> UIButton {
        return radioButton
    }
    
    func getRadioBorderView() -> UIView {
        return radioBorderView
    }
}
