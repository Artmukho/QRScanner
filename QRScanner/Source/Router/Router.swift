//
//  Router.swift
//  QRScanner
//
//  Created by Artem Muho on 21.06.2022.
//

import UIKit

protocol Router {
    func initialMainViewController()
    func showWebView(path: String)
    func showSharedSheet(items: [Any])
    func popToRoot()
}

class MainRouter: Router {
    var navigationController: UINavigationController?
    var assembly: Assembler?
    
    init(navigationController: UINavigationController, assembly: Assembler) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func initialMainViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assembly?.createCaptureModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
        
    func showWebView(path: String) {
        if let navigationController = navigationController {
            guard let viewController = assembly?.createWebViewModule(path: path, router: self) else { return }
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showSharedSheet(items: [Any]) {
        if let navigationController = navigationController {
            guard let sharedViewController = assembly?.createSharedModule(items: items) else { return }
            navigationController.present(sharedViewController, animated: true, completion: nil)
        }
    }
        
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}