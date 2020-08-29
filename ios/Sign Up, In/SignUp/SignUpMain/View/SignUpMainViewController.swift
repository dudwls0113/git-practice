//
//  SignUpViewController.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignUpMainViewController: BaseViewController {
    
    var presenter: SignUpMainPresenterProtocol?
    
    @IBOutlet weak var testConnectionLab: UILabel!
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        
        navigationController?.navigationBar.transparent()
    }
    
    @IBAction func pressedSignUpWithGoogleBtn(_ sender: UIButton) {
        presenter?.pressedSignUpWithGoogle()
    }
    
    @IBAction func pressedSignUpWithFacebookBtn(_ sender: UIButton) {
        presenter?.pressedSignUpWithFacebook()
    }
    
    @IBAction func pressedSignUpWithEmailBtn(_ sender: UIButton) {
        presenter?.presentSignUpWithEmailView()
    }
    
    @IBAction func pressedSignInBtn(_ sender: UIButton) {
        presenter?.presentSignInView()
    }
    
    @IBAction func pressedTermsOfServiceBtn(_ sender: UIButton) {
        presenter?.presentTermsOfServiceView()
    }
}

extension SignUpMainViewController: SignUpMainViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func showTestConnction(_ isSuccessful: Bool) {
        testConnectionLab.text = isSuccessful ? "Connection Successful!" : "Connection Failed."
    }
    
}
