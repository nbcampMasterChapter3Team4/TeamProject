//
//  PayModalViewController.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class PayModalViewController: BaseViewController {
    

    private let deleteButton = DeleteButton()
    private let popButton = UIButton().then {
        $0.setImage(ImageLiterals.iCon.close_button_lightMode_ic, for: .normal)
    }
    
    private let bottomButtonView = CustomBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
    }
    
    override func setStyles() {
        view.backgroundColor = .white200
    }
    
    override func setLayout() {
        view.addSubviews(deleteButton, popButton, bottomButtonView)
        
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(18)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 25 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 68 / 402)
        }
        
        popButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(SizeLiterals.Screen.screenHeight * 30 / 874)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setBottomButton() {
        bottomButtonView.configure("₩190,000", "결제하기")
    }
    
}
