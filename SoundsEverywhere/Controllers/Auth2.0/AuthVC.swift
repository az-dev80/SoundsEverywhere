//
//  AuthVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit
import WebKit
import Gradients

class AuthVC: UIViewController, WKNavigationDelegate {
    private var gradientLayer: CALayer!
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        if #available(iOS 14.0, *) {
            prefs.allowsContentJavaScript = true
        }
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let wb = WKWebView(frame: .zero, configuration: config)
        
        return wb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        gradientLayer = Gradients.solidStone.layer
        view.layer.insertSublayer(gradientLayer, at: 0)
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .clear
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.backgroundColor = .clear
        
        guard  let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        webView.isOpaque = false
        gradientLayer.frame = webView.bounds
    }

    var completionHandler:((Bool)->Void)?
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: false)
                self?.completionHandler?(success)
            }
        }
    }
    
}
