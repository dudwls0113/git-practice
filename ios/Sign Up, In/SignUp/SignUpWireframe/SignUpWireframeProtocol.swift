//
//  SignUpWireframe.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

protocol SignUpWireframeProtocol: class {
    var signInViewController: BaseViewController? { get set }
    
    static func createSignUpMainModule() -> BaseViewController
    static func createSignUpWithEmailModule() -> BaseViewController
    
    func presentSignUpWithEmailScreen(from view: SignUpMainViewProtocol)
    func presentSignUpCheckInboxScreen(from view: SignUpWithEmailViewProtocol, email: String)
    func presentSignInScreen(from view: SignUpMainViewProtocol)
    func presentTermsOfServiceScreen(from view: SignUpMainViewProtocol)
    func presentTermsOfServiceScreen(from view: SignUpWithEmailViewProtocol)
}
