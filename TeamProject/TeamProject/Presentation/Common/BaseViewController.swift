//
//  BaseViewController.swift
//  TeamProject
//
//  Created by 천성우 on 4/7/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    private lazy var viewControllerName = self.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
        setLayout()
        setDelegates()
        setRegister()
    }
    
    /// View 의 Style 을 set 합니다.
    func setStyles() {}
    /// View 의 Layout 을 set 합니다.
    func setLayout() {}
    /// View 의 Delegate 을 set 합니다.
    func setDelegates() {}
    /// View 의 Register 를 set 합니다.
    func setRegister() {}
    
    deinit {
        print("🧶 \(viewControllerName) is deinited")
    }
}

