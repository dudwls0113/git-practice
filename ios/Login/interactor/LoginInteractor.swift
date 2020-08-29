//
//  LoginInteractor.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Alamofire
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    
    func retrieveTestConnection() {
        Alamofire
            .request("\(AppDelegate.baseUrl)/test", method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.presenter?.didRetrieveTestConnection(true)
                case .failure:
                    self.presenter?.didRetrieveTestConnection(false)
                }
            }
        presenter?.didRetrieveTestConnection(false)
    }
    
    func loginWithEmail(email: String, name: String?) {
        //
        
        presenter?.didRetrieveJwtToken(jwt: "JWT")
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
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            self.presenter?.didRetrieveFacebookAuth(credential: credential, accessToken: AccessToken.current!.tokenString, socialId: "facebook")
        }
    }
    
    func isValidInFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                self.presenter?.invalidAuth()
                return
            }
            self.presenter?.didSocialLogin()
        }
    }
    
    func isValidInServer(accessToken: String, socialId: String) {
//        print("pass")
//        print(accessToken)
//        print("pass")
//        presenter?.didRetrieveJwtToken(jwt: "JWT")
        let parameters: Parameters = ["type":socialId, "token":accessToken]
        Alamofire
            .request("\(AppDelegate.baseUrl)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String:Any] {
                        if let result = data["result"] as? [String:String] {
                            if let jwt = result["jwt"] {
                                self.presenter?.didRetrieveJwtToken(jwt: jwt)
                                return
                            }
                        }
                    }
//                    self.presenter?.invalidAuth()
                    self.presenter?.didRetrieveJwtToken(jwt: "JWT")
                case .failure:
//                    self.presenter?.invalidAuth()
                    self.presenter?.didRetrieveJwtToken(jwt: "JWT")
                }
            }
    }
    
    static func signOut(from view: UIViewController) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let signUpNavigationController = UINavigationController(rootViewController: LoginWireframe.createSignUpModule())
        signUpNavigationController.modalPresentationStyle = .fullScreen
        signUpNavigationController.modalTransitionStyle = .crossDissolve
        view.present(signUpNavigationController, animated: true, completion: nil)
    }
    
    
}
