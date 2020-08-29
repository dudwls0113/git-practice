//
//  TermsOfServiceViewController.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import WebKit

class TermsOfServiceViewController: BaseViewController {
        
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var dismissBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        if let url = URL(string: "https://medium.com/policy/medium-terms-of-service-9db0094a1e0f") {
            webView.load(URLRequest(url: url))
        }
        
        dismissBtn.action = Selector(("dissmiss"))
    }
    
    @objc func dissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
