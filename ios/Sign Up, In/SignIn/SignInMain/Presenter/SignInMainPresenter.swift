//
//  SignInMainPresenter.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class SignInMainPresenter: SignInMainPresenterProtocol {
    
    weak var view: SignInMainViewProtocol?
    var interactor: SignInMainInteractorInputProtocol?
    var wireframe: SignInWireframeProtocol?
    
    func signInWithGoogle() {
        //
    }
    
    func signInWithFacebook() {
        //
    }
    
    func presentSignInWithEmailView() {
        wireframe?.presentSignInWithEmailScreen(from: view!)
    }
    
    func presentSignUpView() {
        wireframe?.presentSignUpScreen(from: view!)
    }
    
    func continueWithoutSigningIn() {
        //
    }
    
    
}

extension SignInMainPresenter: SignInMainInteractorOutputProtocol {
    //
}
