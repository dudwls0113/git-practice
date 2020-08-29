//
//  SignUpWithEmailViewController.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class SignUpWithEmailViewController: BaseViewController, SFSafariViewControllerDelegate {

    let actionCodeSettings = ActionCodeSettings()
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailLab: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        
        nameTF.addUnderline(.gray)
        emailTF.addUnderline(.gray)
        
        actionCodeSettings.url = URL(string: "https://www.biryang.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
    }
    
    @IBAction func pressedTermsOfServiceBtn(_ sender: UIButton) {
        presenter?.presentTermsOfServiceView()
    }
    
    @IBAction func pressedCreateAccountBtn() {
        if let name: String = nameTF.text, let email: String = emailTF.text {
            presenter?.pressedLoginWithEmail(email: email, name: name)
        }
    }
}

extension SignUpWithEmailViewController: LoginViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func onError(_ error: String) {
        //
    }
}
