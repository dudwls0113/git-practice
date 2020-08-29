//
//  SocialLoginInteractor.swift
//  Medium
//
//  Created by 윤영일 on 08/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Firebase
import GoogleSignIn
import FBSDKLoginKit
import TwitterKit

class AuthInteractor: AuthInteractorProtocol {
    
    func loginWithEmail(isSignUpPresenter: Bool) {
        
    }
    
    func loginWithGoogle(from view: UIViewController & GIDSignInDelegate) {
        GIDSignIn.sharedInstance()?.presentingViewController = view
        GIDSignIn.sharedInstance()?.delegate = view
        GIDSignIn.sharedInstance().signIn()
    }
    
    func loginWithFacebook(from view: UIViewController & LoginButtonDelegate) {
        FBLoginButton().delegate = view
        let manager = LoginManager()
        manager.logIn(permissions: ["email"], from: view) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if result?.isCancelled == true {
                print("error")
            }
        }
    }
    
    func loginWithTwitter(from view: UIViewController & AuthUIDelegate, presenter: SignInMainInteractorOutputProtocol) {
        let provider = OAuthProvider(providerID: "twitter.com")
        provider.getCredentialWith(view) { credential, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let credential = credential {
                self.isValidInFirebase(credential, presenter: presenter)
            }
        }
    }
    
    func loginAnonymously(presenter: SignInMainPresenter) {
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let credential = authResult?.credential {
                self.isValidInFirebase(credential, presenter: presenter)
            }
        }
    }
    
    func isValidInFirebase(_ credential: AuthCredential, presenter: SignUpMainInteractorOutputProtocol) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                presenter.invalidCredential()
                return
            }
            presenter.didSocialLogin()
        }
    }
    
    func isValidInFirebase(_ credential: AuthCredential, presenter: SignInMainInteractorOutputProtocol) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                presenter.invalidCredential()
                return
            }
            presenter.didSocialLogin()
        }
    }
    
    class func signOut(from view: UIViewController) {
        try! Auth.auth().signOut()
        let signUpNavigationController = UINavigationController(rootViewController: SignUpWireframe.createSignUpMainModule())
        signUpNavigationController.modalPresentationStyle = .fullScreen
        signUpNavigationController.modalTransitionStyle = .crossDissolve
        view.present(signUpNavigationController, animated: true, completion: nil)
    }
}
