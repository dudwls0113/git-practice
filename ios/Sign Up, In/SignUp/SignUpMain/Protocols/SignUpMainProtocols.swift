//
//  SignUpContract.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

// PRESENTER -> VIEW
protocol SignUpMainViewProtocol: class {
    var presenter: SignUpMainPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showTestConnction(_ isSuccessful: Bool)
}

// VIEW -> PRESENTER
protocol SignUpMainPresenterProtocol: class {
    var view: SignUpMainViewProtocol? { get set }
    var interactor: SignUpMainInteractorInputProtocol? { get set }
    var wireframe: SignUpWireframeProtocol? { get set }
    
    func viewDidLoad()
    func pressedSignUpWithGoogle()
    func pressedSignUpWithFacebook()
    func presentSignUpWithEmailView()
    func presentSignInView()
    func presentTermsOfServiceView()
}

// INTERACTOR -> PRESENTER
protocol SignUpMainInteractorOutputProtocol: class {
    func didRetrieveTestConnection(_ isSuccessful: Bool)
}

// PRESENTER -> INTERACTOR
protocol SignUpMainInteractorInputProtocol: class {
    var presenter: SignUpMainInteractorOutputProtocol? { get set }
    
    func retrieveTestConnection()
    func signUpWithGoogle()
    func signUpWithFacebook()
}
