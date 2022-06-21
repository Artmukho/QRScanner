//
//  WebViewPresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol WebViewPresenterProtocol {
    func getRequest()
    func showShared(items: [Any])
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
    
    func showShared(items: [Any]) {
        router?.showSharedSheet(items: items)
    }
    
    func popTo() {
        router?.popToRoot()
    }
}
