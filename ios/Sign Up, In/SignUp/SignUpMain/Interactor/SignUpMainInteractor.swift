//
//  SignUpInteractor.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Alamofire
import Firebase
import GoogleSignIn

class SignUpMainInteractor: SignUpMainInteractorInputProtocol {
        
    var presenter: SignUpMainInteractorOutputProtocol?
    
    func retrieveTestConnection() {
        Alamofire
            .request("\(AppDelegate.baseUrl)/test", method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.presenter?.didRetrieveTestConnection(true)
                case .failure:
                    self.presenter?.didRetrieveTestConnection(false)
                }
            }
        presenter?.didRetrieveTestConnection(false)
    }
    
    
    func signUpWithGoogle() {
        //
    }
    
    func signUpWithFacebook() {
        //
    }
}
