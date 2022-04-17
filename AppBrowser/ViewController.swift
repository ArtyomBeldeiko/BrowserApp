//
//  ViewController.swift
//  AppBrowser
//
//  Created by Artyom Beldeiko on 23.01.22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var URLtextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLtextField.delegate = self
        webView.navigationDelegate = self
        
        let launchPage = "https://www.apple.com"
        
        let url = URL(string: launchPage)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        URLtextField.text = launchPage
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonClicked(_ sender: Any) {
        
        if webView.canGoForward {
            webView.goForward()
        }
        
    }
    
}

// MARK: - ViewControllerExtension


extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let URLString = textField.text!
        let url = URL(string: URLString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        URLtextField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

