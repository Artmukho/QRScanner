//
//  WebViewController.swift
//  QRScanner
//
//  Created by Artem Muho on 19.06.2022.
//

import UIKit
import WebKit

protocol WebViewInput: AnyObject {
    func loadRequest(request: URLRequest)
    func presentShared(path: URL)
}

class WebViewController: UIViewController, WebViewInput {
    
    // MARK: - Properties
    
    var presenter: WebViewoutput?
    private var progressView = UIProgressView(progressViewStyle: .default)
    private var webView = WKWebView()
    
    // MARK: - Lifecycle
    
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
    
    // MARK: - Private methods
    
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
                                          action: #selector(shareButtonTap))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = shareButton
        navigationItem.hidesBackButton = true
    }
    
    @objc private func backButtonTap() {
        presenter?.close()
    }
    
    @objc private func shareButtonTap() {
        presenter?.showShared()
    }
    
    // MARK: - Protocols methods
    
    func loadRequest(request: URLRequest) {
        webView.load(request)
    }
    
    func presentShared(path: URL) {
        if let pdf = try? Data(contentsOf: path) {
            let activityController = UIActivityViewController(activityItems: [pdf] as [Any], applicationActivities: nil)
            activityController.completionWithItemsHandler = { [weak self] activity, comlited, _, error in
                if let activity = activity, activity.rawValue.contains("SaveToFiles") {
                    let alert = UIAlertController(title: comlited ? "Файл сохранен" : "Ошибка",
                                                  message: error?.localizedDescription,
                                                  preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }
            }
            present(activityController, animated: true)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
