//
//  CapturePresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol CaptureViewOutput {
    func catchCode(_ string: String)
}

class CapturePresenter: CaptureViewOutput {
    
    // MARK: - Properties

    private weak var view: CaptureViewController?
    private var router: Router?
    
    // MARK: - Initializer
    
    init(view: CaptureViewController, router: Router) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
    
    func catchCode(_ string: String) {
        router?.showWebView(path: string)
    }
}
