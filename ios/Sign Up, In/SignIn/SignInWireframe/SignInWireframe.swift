//
//  SignInWireframe.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignInWireframe: SignInWireframeProtocol {
    
    var signUpViewController: BaseViewController?
    
    class func createSignInMainModule() -> BaseViewController {
        let view = SignInMainViewController() as SignInMainViewProtocol
        let presenter: SignInMainPresenterProtocol & SignInMainInteractorOutputProtocol = SignInMainPresenter()
        let interactor: SignInMainInteractorInputProtocol = SignInMainInteractor()
        let wireframe: SignInWireframeProtocol = SignInWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    class func createSignInWithEmailModule() -> BaseViewController {
        let view = SignInWithEmailViewController() as SignInWithEmailViewProtocol
        let presenter: SignInWithEmailPresenterProtocol & SignInWithEmailInteractorOutputProtocol = SignInWithEmailPresenter()
        let interactor: SignInWithEmailInteractorInputProtocol = SignInWithEmailInteractor()
        let wireframe: SignInWireframeProtocol = SignInWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func presentSignInWithEmailScreen(from view: SignInMainViewProtocol) {
        let signInWithEmailViewController = SignInWireframe.createSignInWithEmailModule()
        
        if let sourceView = view as? BaseViewController {
            sourceView.navigationController?.show(signInWithEmailViewController, sender: nil)
        }
    }
    
    func presentSignInCheckInboxScreen(from view: SignInWithEmailViewProtocol, email: String) {
        let signInCheckInboxViewController = SignInCheckInboxViewController()
        if let sourceView = view as? BaseViewController {
            sourceView.present(signInCheckInboxViewController, animated: true) {
                signInCheckInboxViewController.emailLab.text = email
            }
        }
    }
    
    func presentSignUpScreen(from view: SignInMainViewProtocol) {
        if (signUpViewController == nil) {
            signUpViewController = SignUpWireframe.createSignUpMainModule()
        }
        let signUpNavigationController = UINavigationController(rootViewController: signUpViewController!)

        if let sourceView = view as? BaseViewController {
            signUpNavigationController.modalPresentationStyle = .fullScreen
            signUpNavigationController.modalTransitionStyle = .crossDissolve
            sourceView.present(signUpNavigationController, animated: true, completion: nil)
        }
    }
}
