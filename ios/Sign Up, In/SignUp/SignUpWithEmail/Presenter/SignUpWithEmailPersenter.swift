//
//  SignUpWithEmailPersenter.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class SignUpWithEmailPresenter: SignUpWithEmailPresenterProtocol {
    
    weak var view: SignUpWithEmailViewProtocol?
    var interactor: SignUpWithEmailInteractorInputProtocol?
    var wireframe: SignUpWireframeProtocol?
        
    func presentTermsOfServiceView() {
        wireframe?.presentTermsOfServiceScreen(from: view!)
    }
    
    func signUp(name: String, email: String) {
        interactor?.postAccount(name: name, email: email)
    }
}

extension SignUpWithEmailPresenter: SignUpWithEmailInteractorOutputProtocol {
    func presentSignUpCheckInboxView(_ email: String) {
        wireframe?.presentSignUpCheckInboxScreen(from: view!, email: email)
    }
    
    func onError(_ error: String) {
        view?.showError(error)
    }
}
