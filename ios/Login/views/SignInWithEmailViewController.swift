//
//  SignInWithEmailViewController.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignInWithEmailViewController: BaseViewController {

    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var emailLab: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        
        emailTF.addUnderline(.gray)
    }
    
    @IBAction func pressedContinueBtn() {
        if let email: String = emailTF.text {
            presenter?.pressedLoginWithEmail(email: email, name: nil)
        }
    }
}

extension SignInWithEmailViewController: LoginViewProtocol {
    
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
