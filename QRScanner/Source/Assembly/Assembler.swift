//
//  Assembler.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit

class Assembler {
    func createCaptureModule() -> UIViewController {
        let view = CaptureViewController()
        let presenter = CapturePresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func createWebViewModule() -> UIViewController {
        let view = WebViewController()
        let presenter = WebViewPresenter()
        
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
