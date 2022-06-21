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

    var view: CaptureViewProtocol?
    var router: Router?
    
    func catchCode(_ string: String) {
        router?.showWebView(path: string)
    }
    
}
