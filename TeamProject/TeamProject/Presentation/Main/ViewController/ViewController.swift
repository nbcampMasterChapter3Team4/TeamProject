//
//  ViewController.swift
//  TeamProject
//
//  Created by 서동환 on 4/4/25.
//

import UIKit

import SnapKit
import Then

class ViewController: BaseViewController {
    
    // MARK: - UI Components
    
    private let segmentedControl = UISegmentedControl().then {
        $0.insertSegment(withTitle: "All", at: 0, animated: true)
        $0.insertSegment(withTitle: "iPhone", at: 0, animated: true)
        $0.insertSegment(withTitle: "Mac", at: 0, animated: true)
        $0.insertSegment(withTitle: "iPad", at: 0, animated: true)
        $0.insertSegment(withTitle: "ACC", at: 0, animated: true)
        $0.selectedSegmentIndex = 0
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        setLayout()
    }
    
    override func setLayout() {
        
    }

}

