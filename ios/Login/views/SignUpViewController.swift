//
//  SignUpViewController.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import SafariServices

class SignUpViewController: BaseViewController, SFSafariViewControllerDelegate {
    
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var testConnectionLab: UILabel!
    
    override func viewDidLoad() {
        navigationController?.navigationBar.transparent()
        
        presenter?.getTestConnection()
        
        FBLoginButton().delegate = self
    }
    
    @IBAction func pressedSignUpWithGoogleBtn(_ sender: UIButton) {
        presenter?.pressedLoginWithGoogle()
    }
    
    @IBAction func pressedSignUpWithFacebookBtn(_ sender: UIButton) {
        presenter?.pressedLoginWithFacebook()
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

extension SignUpViewController: LoginViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func onError(_ error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        alert.show(self, sender: nil)
    }
    
    func showTestConnction(_ isSuccessful: Bool) {
        testConnectionLab.text = isSuccessful ? "Connection Successful!" : "Connection Failed."
    }
}

extension SignUpViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        showIndicator()
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        presenter?.isValidAuth(credential: credential, accessToken: authentication.accessToken, socialId: "google")
    }
}

extension SignUpViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
//        showIndicator()
//                        
//        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//        presenter?.isValidAuth(credential: credential, accessToken: AccessToken.current!.tokenString, socialId: "facebook")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //
    }
}
