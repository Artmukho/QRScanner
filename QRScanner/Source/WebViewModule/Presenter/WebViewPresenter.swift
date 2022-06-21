//
//  WebViewPresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol WebViewPresenterProtocol {
    func getRequest()
    func showShared()
    func popTo()
}

class WebViewPresenter: WebViewPresenterProtocol {
    var view: WebViewProtocol?
    var router: Router?
    var path: String?
    
    func getRequest() {
        guard let url = URL(string: path ?? "") else { return }
        let request = URLRequest(url: url)
        view?.loadRequest(request: request)
    }
    
    func showShared() {
        guard let url = URL(string: path ?? "") else { return }
        view?.presentShared(path: url)
    }
    
    func popTo() {
        router?.popToRoot()
    }
}
