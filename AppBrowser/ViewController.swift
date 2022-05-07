//
//  ViewController.swift
//  AppBrowser
//
//  Created by Artyom Beldeiko on 23.01.22.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController {
    
    let backButton = UIButton()
    let forwardButton = UIButton()
    let URLtextField = UITextField()
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 243 / 255, green: 243 / 255, blue: 243 / 255, alpha: 1)
        
        backButton.setTitle("Back", for: .normal)
        backButton.backgroundColor = UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        backButton.setTitleColor(.black, for: .normal)
        backButton.layer.cornerRadius = 8
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(6)
            make.width.equalTo(56)
            make.height.equalTo(34)
        }
        
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        
        forwardButton.setImage(UIImage(systemName: "arrowshape.zigzag.forward"), for: .normal)
        forwardButton.tintColor = .black
        forwardButton.backgroundColor = UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        forwardButton.setTitleColor(.black, for: .normal)
        forwardButton.layer.cornerRadius = 8
        view.addSubview(forwardButton)
        
        forwardButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(6)
            make.width.equalTo(56)
            make.height.equalTo(34)
        }
        
        forwardButton.addTarget(self, action: #selector(forwardButtonClicked), for: .touchUpInside)
        
        URLtextField.layer.borderWidth = 1
        URLtextField.layer.cornerRadius = 8
        URLtextField.layer.borderColor = CGColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
        view.addSubview(URLtextField)
        
        URLtextField.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(8)
            make.leading.equalTo(72)
            make.centerXWithinMargins.equalToSuperview()
            make.height.equalTo(34)
        }
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.topMargin.equalTo(URLtextField).inset(40)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        URLtextField.delegate = self
        webView.navigationDelegate = self
        
        let launchPage = "https://www.apple.com"
        
        let url = URL(string: launchPage)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        URLtextField.text = launchPage
    }
    
    //    MARK: - Buttons' Logic
    
    @objc func backButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func forwardButtonClicked() {
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

