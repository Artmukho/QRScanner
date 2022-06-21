//
//  Assembler.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit

class Assembler {
    func createCaptureModule(router: Router) -> UIViewController {
        let view = CaptureViewController()
        let presenter = CapturePresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createWebViewModule(path: String, router: Router) -> UIViewController {
        let view = WebViewController()
        let presenter = WebViewPresenter(path: path, view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
