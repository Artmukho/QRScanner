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
        let assembler = Assembler()
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: assembler.createWebViewModule())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

