//
//  SignInViewController.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignInMainViewController: BaseViewController {
    
    var presenter: SignInMainPresenterProtocol?
    
    override func viewDidLoad() {
        navigationController?.navigationBar.transparent()
    }
    
    @IBAction func pressedSignInWithEmailBtn(_ sender: UIButton) {
        show(SignInWithEmailViewController(), sender: nil)
    }
    
    @IBAction func pressedSignUpBtn(_ sender: UIButton) {
        presenter?.presentSignUpView()
    }
}

extension SignInMainViewController: SignInMainViewProtocol {
    
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
}
