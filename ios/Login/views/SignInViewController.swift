//
//  SignInViewController.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SignInViewController: BaseViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        navigationController?.navigationBar.transparent()
    }
    
    @IBAction func pressedSignInWithGoogleBtn(_ sender: UIButton) {
        presenter?.pressedLoginWithGoogle()
    }
    
    @IBAction func pressedSignInWithFacebookBtn(_ sender: UIButton) {
        presenter?.pressedLoginWithFacebook()
    }
    
    @IBAction func pressedSignInWithEmailBtn(_ sender: UIButton) {
        presenter?.presentSignInWithEmailView()
    }
    
    @IBAction func pressedSignInAnonymously(_ sender: UIButton) {
        presenter?.presentMediumView()
    }
    
    @IBAction func pressedSignUpBtn(_ sender: UIButton) {
        presenter?.presentSignUpView()
    }
}

extension SignInViewController: LoginViewProtocol {
    
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

extension SignInViewController: GIDSignInDelegate {
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

extension SignInViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        showIndicator()
                        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        presenter?.isValidAuth(credential: credential, accessToken: AccessToken.current!.tokenString, socialId: "facebook")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //
    }
}
