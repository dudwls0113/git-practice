//
//  LoginWireframe.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SafariServices

class LoginWireframe: LoginWireframeProtocol {
        
    static func createSignUpModule() -> BaseViewController {
        let view = SignUpViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireframe: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func createSignInModule() -> BaseViewController {
        let view = SignInViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireframe: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func createSignUpWithEmailModule() -> BaseViewController {
        let view = SignUpWithEmailViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireframe: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func createSignInWithEmailModule() -> BaseViewController {
        let view = SignInWithEmailViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireframe: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func createSignInWithNameModule() -> BaseViewController {
        let view = SignInWithNameViewController() as LoginViewProtocol
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        let wireframe: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func presentSignUpScreen(from view: UIViewController) {
        let signUpViewController: BaseViewController = LoginWireframe.createSignUpModule()
        let signUpNavigationController = UINavigationController(rootViewController: signUpViewController)
        signUpNavigationController.modalPresentationStyle = .fullScreen
        signUpNavigationController.modalTransitionStyle = .crossDissolve
        view.present(signUpNavigationController, animated: true, completion: nil)
    }
    
    func presentSignInScreen(from view: UIViewController) {
        let signInViewController: BaseViewController = createSignInModule()
        let signInNavigationController = UINavigationController(rootViewController: signInViewController)
        signInNavigationController.modalPresentationStyle = .fullScreen
        signInNavigationController.modalTransitionStyle = .crossDissolve
        view.present(signInNavigationController, animated: true, completion: nil)
    }
    
    func presentSignUpWithEmailScreen(from view: UIViewController) {
        view.navigationController?.pushViewController(createSignUpWithEmailModule(), animated: true)
//        view.show(createSignUpWithEmailModule(), sender: nil)
    }
    
    func presentSignInWithEmailScreen(from view: UIViewController) {
        view.navigationController?.pushViewController(createSignInWithEmailModule(), animated: true)
//        view.show(createSignInWithEmailModule(), sender: nil)
    }
    
    func presentSignInWithNameScreen(from view: UIViewController) {
        view.navigationController?.pushViewController(createSignInWithNameModule(), animated: true)
//        view.show(createSignInWithNameModule(), sender: nil)
    }
    
    func presentCheckInboxScreen(from view: UIViewController, email: String) {
        let checkInboxViewController = CheckInboxViewController()
        view.present(CheckInboxViewController(), animated: true) {
            checkInboxViewController.setEmail(email)
        }
    }
    
    func presentTermsOfServiceScreen(from view: UIViewController & SFSafariViewControllerDelegate) {
        if let url = URL(string: "https://medium.com/policy/medium-terms-of-service-9db0094a1e0f") {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = view
            safariViewController.modalPresentationStyle = .popover
            view.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func presentMediumScreen(from view: UIViewController, jwt: String?) {
        let mediumViewController = TabBarController()
        mediumViewController.modalPresentationStyle = .fullScreen
        mediumViewController.modalTransitionStyle = .crossDissolve
        view.present(mediumViewController, animated: true, completion: nil)
    }
    
    
}
