//
//  SignUpWithEmailProtocols.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

// PRESENTER -> VIEW
protocol SignUpWithEmailViewProtocol: class {
    var presenter: SignUpWithEmailPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(_ error: String)
}

// VIEW -> PRESENTER
protocol SignUpWithEmailPresenterProtocol: class {
    var view: SignUpWithEmailViewProtocol? { get set }
    var interactor: SignUpWithEmailInteractorInputProtocol? { get set }
    var wireframe: SignUpWireframeProtocol? { get set }
    
    func presentTermsOfServiceView()
    func signUp(name: String, email: String)
}

// INTERACTOR -> PRESENTER
protocol SignUpWithEmailInteractorOutputProtocol: class {
    func presentSignUpCheckInboxView(_ email: String)
    func onError(_ error: String)
}

// PRESENTER -> INTERACTOR
protocol SignUpWithEmailInteractorInputProtocol: class {
    var presenter: SignUpWithEmailInteractorOutputProtocol? { get set }
        
    func postAccount(name: String, email: String)
}
