//
//  SignInWithEmailPresenter.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class SignInWithEmailPresenter: SignInWithEmailPresenterProtocol {
    
    weak var view: SignInWithEmailViewProtocol?
    var interactor: SignInWithEmailInteractorInputProtocol?
    var wireframe: SignInWireframeProtocol?
    
    var email: String?
    
    func signIn(_ email: String) {
        self.email = email
        interactor?.confirmAccountEmail(email)
    }
}

extension SignInWithEmailPresenter: SignInWithEmailInteractorOutputProtocol {
    func presentSignInCheckInboxView() {
        wireframe?.presentSignInCheckInboxScreen(from: view!, email: email!)
    }
    
    func onError(_ error: String) {
        view?.showError(error)
    }
}
