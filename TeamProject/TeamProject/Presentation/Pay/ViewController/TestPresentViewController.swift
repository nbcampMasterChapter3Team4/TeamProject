//
//  TestPresentViewController.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class TestPresentViewController: BaseViewController {
    
    private let bottomButtonView = CustomBottomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
        setAddTarget()
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
    
    func setAddTarget() {
        bottomButtonView.getRightButton().addTarget(self, action: #selector(presentToPayViewController), for: .touchUpInside)
    }
    
    func setBottomButton() {
        bottomButtonView.configure("₩190,000", "결제하기")
    }
    
    @objc
    func presentToPayViewController() {
        let vc = PayModalViewController()
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                return context.maximumDetentValue * 0.8445
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true, completion: nil)
    }

}
