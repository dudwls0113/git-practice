//
//  CreateWireframe.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class CreateWireframe: CreateWireframeProtocol {
    static func createCreateBeginModule() -> BaseViewController {
        return CreateBeginViewController()
    }
    
    static func createCreateModule() -> BaseViewController {
        let view: CreateViewProtocol = CreateViewController()
        let presenter: CreatePresenterProtocol & CreateOutputInteractorProtocol = CreatePresenter()
        let interactor: CreateInputInteractorProtocol = CreateInteractor()
        let wireframe: CreateWireframeProtocol = CreateWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
}
