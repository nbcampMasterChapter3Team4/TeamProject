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
    
    private let bottomButtonView = CustomBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
    }
    
    override func setStyles() {
        view.backgroundColor = .white200
    }
    
    override func setLayout() {
        view.addSubviews(bottomButtonView)
        
        bottomButtonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setBottomButton() {
        bottomButtonView.configure("₩190,000", "결제하기")
    }
    
}
