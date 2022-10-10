//
//  WebViewPresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol WebViewoutput: AnyObject {
    func getRequest()
    func showShared()
    func close()
}

class WebViewPresenter: WebViewoutput {
    
    // MARK: - Properties
    
    private weak var view: WebViewInput?
    private var router: Router?
    private var path: String
    
    // MARK: - Initializer
    
    init(path: String, view: WebViewInput, router: Router) {
        self.view = view
        self.router = router
        self.path = path
    }
    
    // MARK: - Methods
    
    func getRequest() {
        guard let url = URL(string: path) else { return }
        let request = URLRequest(url: url)
        view?.loadRequest(request: request)
    }
    
    func showShared() {
        guard let url = URL(string: path) else { return }
        view?.presentShared(path: url)
    }
    
    func close() {
        router?.popToRoot()
    }
}
