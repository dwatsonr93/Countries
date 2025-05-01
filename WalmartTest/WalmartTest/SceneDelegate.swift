//
//  SceneDelegate.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: CountryListViewController())
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}
