//
//  SocialLoginInteractorProtocol.swift
//  Medium
//
//  Created by 윤영일 on 08/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Firebase
import GoogleSignIn
import FBSDKLoginKit

protocol AuthInteractorProtocol {
    
    func loginWithEmail(isSignUpPresenter: Bool)
    func loginWithGoogle(from view: UIViewController & GIDSignInDelegate)
    func loginWithFacebook(from view: UIViewController & LoginButtonDelegate)
    func loginWithTwitter(from view: UIViewController & AuthUIDelegate, presenter: SignInMainInteractorOutputProtocol)
    func loginAnonymously(presenter: SignInMainPresenter)
    func isValidInFirebase(_ credential: AuthCredential, presenter: SignUpMainInteractorOutputProtocol)
    func isValidInFirebase(_ credential: AuthCredential, presenter: SignInMainInteractorOutputProtocol)
//    func isValidInServer(_ accessToken: String)
    
    static func signOut(from view: UIViewController)
}
