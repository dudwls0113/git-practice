//
//  SignUpWithEmailViewController.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignUpWithEmailViewController: BaseViewController {

    var presenter: SignUpWithEmailPresenterProtocol?
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailLab: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        
        nameTF.addUnderline(.gray)
        emailTF.addUnderline(.gray)
    }
    
    @IBAction func pressedCreateAccountBtn() {
        if let name: String = nameTF.text, let email: String = emailTF.text {
            presenter?.signUp(name: name, email: email)
        }
    }
}

extension SignUpWithEmailViewController: SignUpWithEmailViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func showError(_ error: String) {
        //
    }
}
