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
        $0.image = {
            if UITraitCollection.current.userInterfaceStyle == .light {
                return ImageLiterals.iCon.trash_black_ic
            } else {
                return ImageLiterals.iCon.trash_white_ic
            }
        }()
    }

    private let detailTextLabel = UILabel().then {
        $0.text = "전체 삭제"
        $0.textColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return .black100
            } else {
                return .white200
            }
        }
        $0.font = .fontGuide(.payModalDeleteLabel)
    }

    // MARK: - Override

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
    }

    // 화면 모드 변환 탐지
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // 이전과 현재 모드가 다를 때만 이미지 갱신
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            deleteImage.image = traitCollection.userInterfaceStyle == .light
                ? ImageLiterals.iCon.trash_black_ic
            : ImageLiterals.iCon.trash_white_ic
        }
    }

    // MARK: - Style Helper

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
