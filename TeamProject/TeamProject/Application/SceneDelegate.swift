//
//  SceneDelegate.swift
//  TeamProject
//
//  Created by 서동환 on 4/4/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = navigationController
        
        self.window?.makeKeyAndVisible()
    }
}
