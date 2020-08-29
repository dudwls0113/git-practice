//
//  SignInWithEmailInteractor.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class SignInWithEmailInteractor: SignInWithEmailInteractorInputProtocol {
    
    var presenter: SignInWithEmailInteractorOutputProtocol?
    
    func confirmAccountEmail(_ email: String) {
        let isSuccessful = true
        if (isSuccessful) {
            presenter?.presentSignInCheckInboxView()
        } else {
            presenter?.onError("Error")
        }
    }
}
