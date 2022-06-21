//
//  CapturePresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol CapturePresenterProtocol {
    func catchCode(_ string: String)
}

class CapturePresenter: CapturePresenterProtocol {
    
    //MARK: - Properties

    weak var view: CaptureViewController?
    var router: Router?
    
    //MARK: - Initializer
    
    init(view: CaptureViewController, router: Router) {
        self.view = view
        self.router = router
    }
    
    //MARK: - Methods
    
    func catchCode(_ string: String) {
        router?.showWebView(path: string)
    }
    
}
