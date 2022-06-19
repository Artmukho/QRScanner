//
//  WebViewPresenter.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import Foundation

protocol WebViewPresenterProtocol {
    func getRequest()
}

class WebViewPresenter: WebViewPresenterProtocol {
    var view: WebViewProtocol?
    
    func getRequest() {
        guard let url = URL(string: "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf") else { return }
        let request = URLRequest(url: url)
        view?.loadRequest(request: request)
    }
}
