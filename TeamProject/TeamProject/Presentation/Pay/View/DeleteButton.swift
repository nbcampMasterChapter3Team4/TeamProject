//
//  DeleteButton.swift
//  TeamProject
//
//  Created by 천성우 on 4/8/25.
//

import UIKit

import SnapKit
import Then

class DeleteButton: UIButton {
    
    // MARK: - UI Components

    private let deleteImage = UIImageView().then {
        $0.image = ImageLiterals.iCon.trash_black_ic
    }

    private let detailTextLabel = UILabel().then {
        $0.text = "전체 삭제"
        $0.textColor = .black100
        $0.font = .fontGuide(.payModalDeleteLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }
    
    private func setStyles() {
        self.backgroundColor = .clear
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        addSubviews(deleteImage, detailTextLabel)
        
        deleteImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 25 / 874)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 20 / 402)
        }
        
        detailTextLabel.snp.makeConstraints {
            $0.centerY.equalTo(deleteImage.snp.centerY)
            $0.trailing.equalToSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
