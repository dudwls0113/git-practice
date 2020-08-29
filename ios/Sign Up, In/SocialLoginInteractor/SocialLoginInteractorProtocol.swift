//
//  SocialLoginInteractorProtocol.swift
//  Medium
//
//  Created by 윤영일 on 08/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

protocol ScocialLoginInteractorProtocol {
    
    var signUpPresenter: SignUpMainPresenter? { get set }
    var signInPresenter: SignInMainPresenter? { get set }
    
    func signInWithgoogle()
    func signInWithFacebook()
    func signInWithTwitter()
    func signInWithEmail()
}
