//
//  LoginProtocols.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/08.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SafariServices
import Firebase
import GoogleSignIn
import FBSDKLoginKit

// PRESENTER -> VIEW
protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func onError(_ error: String)
}

// VIEW -> PRESENTER
protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireframe: LoginWireframeProtocol? { get set }
    
    func getTestConnection()
    
    func pressedLoginWithGoogle()
    func pressedLoginWithFacebook()
    func pressedLoginWithEmail(email: String, name: String?)
    
    func presentSignUpWithEmailView()
    func presentSignInWithEmailView()
    func presentSignInWithNameView()
    func presentSignUpView()
    func presentSignInView()
    func presentTermsOfServiceView()
    func presentMediumView()
    
    func isValidAuth(credential: AuthCredential, accessToken: String, socialId: String)
}

// INTERACTOR -> PRESENTER
protocol LoginInteractorOutputProtocol: class {
    func didRetrieveTestConnection(_ isSuccessful: Bool)
    func didRetrieveFacebookAuth(credential: AuthCredential, accessToken: String, socialId: String)
    func didSocialLogin()
    func didRetrieveJwtToken(jwt: String)
    func invalidAuth()
}

// PRESENTER -> INTERACTOR
protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    func retrieveTestConnection()
    
    func loginWithEmail(email: String, name: String?)
    func loginWithGoogle(from view: UIViewController & GIDSignInDelegate)
    func loginWithFacebook(from view: UIViewController & LoginButtonDelegate)
    
    func isValidInFirebase(credential: AuthCredential)
    func isValidInServer(accessToken: String, socialId: String)
        
    static func signOut(from view: UIViewController)
}

// PRESENTER -> WIREFRAME
protocol LoginWireframeProtocol: class {
    
    static func createSignUpModule() -> BaseViewController
    func createSignInModule() -> BaseViewController
    func createSignUpWithEmailModule() -> BaseViewController
    func createSignInWithEmailModule() -> BaseViewController
    func createSignInWithNameModule() -> BaseViewController
    
    func presentSignUpScreen(from view: UIViewController)
    func presentSignInScreen(from view: UIViewController)
    func presentSignUpWithEmailScreen(from view: UIViewController)
    func presentSignInWithEmailScreen(from view: UIViewController)
    func presentSignInWithNameScreen(from view: UIViewController)
    func presentCheckInboxScreen(from view: UIViewController, email: String)
    func presentTermsOfServiceScreen(from view: UIViewController & SFSafariViewControllerDelegate)
    func presentMediumScreen(from view: UIViewController, jwt: String?)
}
