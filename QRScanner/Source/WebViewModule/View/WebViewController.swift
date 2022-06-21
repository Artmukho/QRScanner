//
//  WebViewController.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit
import WebKit

protocol WebViewProtocol {
    func loadRequest(request: URLRequest)
}

class WebViewController: UIViewController, WebViewProtocol {
    
    //MARK: - Properties
    
    var presenter: WebViewPresenterProtocol?
    private var progressView = UIProgressView(progressViewStyle: .default)
    private var webView = WKWebView()
    
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        setupNavigationBar()
        setupHierarchy()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        presenter?.getRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    
    //MARK: - Private methods
    
    private func setupHierarchy() {
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTap))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                          style: .plain,
                                          target: self,
                                          action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.hidesBackButton = true
    }
    
    @objc func backButtonTap() {
        presenter?.popTo()
    }
    
    //MARK: - Protocols methods
    
    func loadRequest(request: URLRequest) {
        webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
