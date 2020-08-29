//
//  SignUpPresenter.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class SignUpMainPresenter: SignUpMainPresenterProtocol {
    
    weak var view: SignUpMainViewProtocol?
    var interactor: SignUpMainInteractorInputProtocol?
    var wireframe: SignUpWireframeProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveTestConnection()
    }
    
    func pressedSignUpWithGoogle() {
        interactor?.signUpWithGoogle()
    }
    
    func pressedSignUpWithFacebook() {
        interactor?.signUpWithFacebook()
    }
    
    func presentSignUpWithEmailView() {
        wireframe?.presentSignUpWithEmailScreen(from: view!)
    }
    
    func presentSignInView() {
        wireframe?.presentSignInScreen(from: view!)
    }
    
    func presentTermsOfServiceView() {
        wireframe?.presentTermsOfServiceScreen(from: view!)
    }
    
    
}

extension SignUpMainPresenter: SignUpMainInteractorOutputProtocol {
    func didRetrieveTestConnection(_ isSuccessful: Bool) {
        view?.hideLoading()
        view?.showTestConnction(isSuccessful)
    }
}
