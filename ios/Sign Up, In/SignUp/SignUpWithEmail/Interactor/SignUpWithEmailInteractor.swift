//
//  SignUpWithEmailInteractor.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import FirebaseAuth

class SignUpWithEmailInteractor: SignUpWithEmailInteractorInputProtocol {
    
    let actionCodeSettings = ActionCodeSettings()
    
    init() {
        actionCodeSettings.url = URL(string: AppDelegate.firebaseUrl)
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
    }
    
    var presenter: SignUpWithEmailInteractorOutputProtocol?
    
    func postAccount(name: String, email: String) {
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
            if let error: Error = error {
                self.presenter?.onError(error.localizedDescription)
                return
            }
            UserDefaults.standard.set(email, forKey: email)
            self.presenter?.presentSignUpCheckInboxView(email)
        }
        presenter?.onError("Conenction Error!")
    }
}
