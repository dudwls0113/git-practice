//
//  SignUpWireframe.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignUpWireframe: SignUpWireframeProtocol {
    
    var signInViewController: BaseViewController?
    
    class func createSignUpMainModule() -> BaseViewController {
        let view = SignUpMainViewController() as SignUpMainViewProtocol
        let presenter: SignUpMainPresenterProtocol & SignUpMainInteractorOutputProtocol = SignUpMainPresenter()
        let interactor: SignUpMainInteractorInputProtocol = SignUpMainInteractor()
        let wireframe: SignUpWireframeProtocol = SignUpWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    class func createSignUpWithEmailModule() -> BaseViewController {
        let view = SignUpWithEmailViewController() as SignUpWithEmailViewProtocol
        let presenter: SignUpWithEmailPresenterProtocol & SignUpWithEmailInteractorOutputProtocol = SignUpWithEmailPresenter()
        let interactor: SignUpWithEmailInteractorInputProtocol = SignUpWithEmailInteractor()
        let wireframe: SignUpWireframeProtocol = SignUpWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func presentSignUpWithEmailScreen(from view: SignUpMainViewProtocol) {
        let signUpWithEmailViewController = SignUpWireframe.createSignUpWithEmailModule()
        
        if let sourceView = view as? BaseViewController {
            
            sourceView.navigationController?.show(signUpWithEmailViewController, sender: nil)
        }
    }
    
    func presentSignUpCheckInboxScreen(from view: SignUpWithEmailViewProtocol, email: String) {
        let signUpCheckInboxViewController = SignUpCheckInboxViewController()
        if let sourceView = view as? BaseViewController {
            sourceView.present(signUpCheckInboxViewController, animated: true) {
                signUpCheckInboxViewController.emailLab.text = email
            }
        }
    }
    
    func presentSignInScreen(from view: SignUpMainViewProtocol) {
        if signInViewController == nil {
            signInViewController = SignInWireframe.createSignInMainModule()
        }
        let signInNavigationController = UINavigationController(rootViewController: signInViewController!)

        if let sourceView = view as? BaseViewController {
            signInNavigationController.modalPresentationStyle = .fullScreen
            signInNavigationController.modalTransitionStyle = .crossDissolve
            sourceView.present(signInNavigationController, animated: true, completion: nil)
        }
    }
    
    func presentTermsOfServiceScreen(from view: SignUpMainViewProtocol) {
        if let sourceView = view as? BaseViewController {
            sourceView.present(TermsOfServiceViewController(), animated: true, completion: nil)
        }
    }
    
    func presentTermsOfServiceScreen(from view: SignUpWithEmailViewProtocol) {
        if let sourceView = view as? BaseViewController {
            sourceView.present(TermsOfServiceViewController(), animated: true, completion: nil)
        }
    }
}
