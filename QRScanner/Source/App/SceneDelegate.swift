//
//  SceneDelegate.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let assembly = Assembler()
        let router = MainRouter(navigationController: navigationController, assembly: assembly)
        router.initialMainViewController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

