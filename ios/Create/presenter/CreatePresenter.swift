//
//  CreatePresenter.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class CreatePresenter: CreatePresenterProtocol {
    
    var view: CreateViewProtocol?
    var interactor: CreateInputInteractorProtocol?
    var wireframe: CreateWireframeProtocol?
    
    func createStory(title: String, contents: [TempContents]) {
        view?.showLoading()
        interactor?.postStory(title: title, contents: contents)
    }
}

extension CreatePresenter: CreateOutputInteractorProtocol {
    func failedToPostStory(_ error: Error? = nil) {
        if let error = error {
            print(error.localizedDescription)
        }
        view?.hideLoading()
        view?.showFailureAlert()
    }
    
    func didPostStory(_ storyId: Int) {
        view?.hideLoading()
        view?.showSuccessAlert()
    }
}
