//
//  WikiViewController.swift
//  Project16
//
//  Created by Raphael de Jesus on 15/02/22.
//

import UIKit
import WebKit

class WikiViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    let url = "https://pt.wikipedia.org/wiki/"
    var country: String = ""
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let link = URL(string: url + country) else {
            return
        }
        print(link)
        webView.load(URLRequest(url: link))
        webView.allowsBackForwardNavigationGestures = true
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
                    decisionHandler(.allow)
                    return
        }
        
        decisionHandler(.cancel)
    }

}
