//
//  SignInWithNameViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignInWithNameViewController: BaseViewController {
    
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        
        nameTF.addUnderline(.gray)
    }
    
    @IBAction func pressedContinueBtn() {
        if let name: String = nameTF.text {
//            presenter?.pressedLoginWithEmail(email: email)
            print(name)
        }
    }
}

extension SignInWithNameViewController: LoginViewProtocol {
    
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
