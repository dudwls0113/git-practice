//
//  SignInWithEmailProtocols.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

// PRESENTER -> VIEW
protocol SignInWithEmailViewProtocol: class {
    var presenter: SignInWithEmailPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showError(_ error: String)
}

// VIEW -> PRESENTER
protocol SignInWithEmailPresenterProtocol: class {
    var view: SignInWithEmailViewProtocol? { get set }
    var interactor: SignInWithEmailInteractorInputProtocol? { get set }
    var wireframe: SignInWireframeProtocol? { get set }
    
    func signIn(_ email: String)
}

// INTERACTOR -> PRESENTER
protocol SignInWithEmailInteractorOutputProtocol: class {
    func presentSignInCheckInboxView()
    func onError(_ error: String)
}

// PRESENTER -> INTERACTOR
protocol SignInWithEmailInteractorInputProtocol: class {
    var presenter: SignInWithEmailInteractorOutputProtocol? { get set }
        
    func confirmAccountEmail(_ email: String)
}
