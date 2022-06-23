//
//  Router.swift
//  QRScanner
//
//  Created by Artem Muho on 21.06.2022.
//

import UIKit

protocol Router: AnyObject {
    func initialMainViewController()
    func showWebView(path: String)
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
        
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
