//
//  CreateProtocols.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol CreateViewProtocol: class {
    var presenter: CreatePresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showSuccessAlert()
    func showFailureAlert()
}

// VIEW -> PRESENTER
protocol CreatePresenterProtocol: class {
    var view: CreateViewProtocol? { get set }
    var interactor: CreateInputInteractorProtocol? { get set }
    var wireframe: CreateWireframeProtocol? { get set }
        
    func createStory(title: String, contents: [TempContents])
}

// INTERACTOR -> PRESENTER
protocol CreateOutputInteractorProtocol: class {
    func failedToPostStory(_ error: Error?)
    func didPostStory(_ storyId: Int)
}

// PRESENTER -> INTERACTOR
protocol CreateInputInteractorProtocol: class {
    var presenter: CreateOutputInteractorProtocol? { get set }
    
    func postStory(title: String, contents tempContents: [TempContents])
}

// PRESENTER -> WIREFRAME
protocol CreateWireframeProtocol: class {
    static func createCreateBeginModule() -> BaseViewController
    static func createCreateModule() -> BaseViewController
}
