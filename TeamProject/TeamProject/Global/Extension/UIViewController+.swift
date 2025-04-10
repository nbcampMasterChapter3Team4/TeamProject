//
//  UIViewController+.swift
//  TeamProject
//
//  Created by yimkeul on 4/9/25.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        preferredStyle: UIAlertController.Style = .alert
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
    
    func makeAlertAction(
        title: String,
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}

