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
        radioBorderView.layer.borderColor = isSelected ? UIColor.blue200.cgColor : UIColor.black100.cgColor
    }

    func getRadioButton() -> UIButton {
        return radioButton
    }
    
    func getRadioBorderView() -> UIView {
        return radioBorderView
    }
}
