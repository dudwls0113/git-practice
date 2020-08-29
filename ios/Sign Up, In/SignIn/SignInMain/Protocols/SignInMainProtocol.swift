//
//  SignInMainProtocol.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

// PRESENTER -> VIEW
protocol SignInMainViewProtocol: class {
    var presenter: SignInMainPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
}

// VIEW -> PRESENTER
protocol SignInMainPresenterProtocol: class {
    var view: SignInMainViewProtocol? { get set }
    var interactor: SignInMainInteractorInputProtocol? { get set }
    var wireframe: SignInWireframeProtocol? { get set }
    
//    func viewDidLoad()
    func signInWithGoogle()
    func signInWithFacebook()
    func presentSignInWithEmailView()
    func presentSignUpView()
    func continueWithoutSigningIn()
}

// INTERACTOR -> PRESENTER
protocol SignInMainInteractorOutputProtocol: class {
    //
}

// PRESENTER -> INTERACTOR
protocol SignInMainInteractorInputProtocol: class {
    var presenter: SignInMainInteractorOutputProtocol? { get set }
    
    //
}
