//
//  DetailViewController.swift
//  project4
//
//  Created by Ainura Kerimkulova on 15/2/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [String]()
    var currentWebsite: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let goBack = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [goBack, goForward, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        let url = URL(string: "https://" + currentWebsite!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
        
    }
    
    func openPage(action: UIAlertAction){
        
        let url = URL(string: "https://" + action.title!)!
        currentWebsite = action.title
        webView.load(URLRequest(url: url))
    }
    
    func isAdult(action: UIAlertAction){
        if action.title == "Yes"{
            let url = URL(string: "https://omegle.com")!
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            travelToWebsite(host, decisionHandler)
        } else {
            decisionHandler(.cancel)
        }
    }
    
    private func travelToWebsite(_ host: String, _ decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let currentWebsite = currentWebsite, currentWebsite == "omegle.com" {
            let vc = UIAlertController(title: "Omegle is blocked", message: "Are you adult", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Yes", style: .default) { [decisionHandler] action in
                decisionHandler(.allow)
            })
            
            vc.addAction(UIAlertAction(title: "No", style: .default) { [decisionHandler] action in
                decisionHandler(.cancel)
            })
            vc.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(vc, animated: true)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func tempMethod() {
//        if let host = url?.host {
//            for website in websites {
//                if host.contains(website) {
//                    if website != "omegle.com"{
//                        decisionHandler(.allow)
//                        return
//                    } else {
//                        let vc = UIAlertController(title: "Omegle is blocked", message: "Are you adult", preferredStyle: .alert)
//                        vc.addAction(UIAlertAction(title: "Yes", style: .default){ [decisionHandler] action in
//                            decisionHandler(.allow)
//                            return
//                        })
//                        vc.addAction(UIAlertAction(title: "No", style: .default){ [decisionHandler] action in
//                            decisionHandler(.cancel)
//                            return
//                        })
//                        vc.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
//
//                        present(vc, animated: true)
//
//                    }
//                }
//            }
//        }
//        decisionHandler(.cancel)
    }
}


