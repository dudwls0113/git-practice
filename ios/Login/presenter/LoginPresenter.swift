//
//  LoginPresenter.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/08.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import SafariServices
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginPresenter: LoginPresenterProtocol {
    
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireframe: LoginWireframeProtocol?
    
    var accessToken: String?
    var socialId: String?
    
    func getTestConnection() {
        view?.showLoading()
        interactor?.retrieveTestConnection()
    }
    
    func pressedLoginWithGoogle() {
        if let view = view as? UITableViewController & GIDSignInDelegate {
            interactor?.loginWithGoogle(from: view)
        }
    }
    
    func pressedLoginWithFacebook() {
        if let view = view as? UITableViewController & LoginButtonDelegate {
            interactor?.loginWithFacebook(from: view)
        }
    }
    
    func pressedLoginWithEmail(email: String, name: String?) {
        interactor?.loginWithEmail(email: email, name: name)
    }
    
    func presentSignUpWithEmailView() {
        if let view = view as? UIViewController {
            wireframe?.presentSignUpWithEmailScreen(from: view)
        }
    }
    
    func presentSignInWithEmailView() {
        if let view = view as? UIViewController {
            wireframe?.presentSignInWithEmailScreen(from: view)
        }
    }
    
    func presentSignInWithNameView() {
        if let view = view as? UIViewController {
            wireframe?.presentSignInWithNameScreen(from: view)
        }
    }
    
    func presentSignUpView() {
        wireframe?.presentSignUpScreen(from: view! as! UIViewController)
    }
    
    func presentSignInView() {
        if let view = view as? UIViewController {
            wireframe?.presentSignInScreen(from: view)
        }
    }
    
    func presentTermsOfServiceView() {
        if let view = view as? UIViewController & SFSafariViewControllerDelegate {
            wireframe?.presentTermsOfServiceScreen(from: view)
        }
    }
    
    func presentMediumView() {
        wireframe?.presentMediumScreen(from: view! as! UIViewController, jwt: nil)
    }
    
    func isValidAuth(credential: AuthCredential, accessToken: String, socialId: String) {
        self.accessToken = accessToken
        self.socialId = socialId
        interactor?.isValidInFirebase(credential: credential)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didRetrieveTestConnection(_ isSuccessful: Bool) {
        view?.hideLoading()
        if let view = view as? SignUpViewController {
            view.showTestConnction(isSuccessful)
        }
    }
    
    func didRetrieveFacebookAuth(credential: AuthCredential, accessToken: String, socialId: String) {
        view?.showLoading()
        isValidAuth(credential: credential, accessToken: accessToken, socialId: socialId)
    }
    
    func didSocialLogin() {
        if let accessToken = accessToken, let socialId = socialId {
            interactor?.isValidInServer(accessToken: accessToken, socialId: socialId)
        }
    }
    
    func didRetrieveJwtToken(jwt: String) {
        if let view = view as? UIViewController {
            wireframe?.presentMediumScreen(from: view, jwt: jwt)
        }
    }
    
    func invalidAuth() {
        view?.onError("Failed to sign in with \(socialId!).")
    }
}
