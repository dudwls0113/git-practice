//
//  SignInWireframeProtocol.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

protocol SignInWireframeProtocol: class {
    var signUpViewController: BaseViewController? { get set }
    
    static func createSignInMainModule() -> BaseViewController
    static func createSignInWithEmailModule() -> BaseViewController
    
    func presentSignInWithEmailScreen(from view: SignInMainViewProtocol)
    func presentSignInCheckInboxScreen(from view: SignInWithEmailViewProtocol, email: String)
    func presentSignUpScreen(from view: SignInMainViewProtocol)
}
