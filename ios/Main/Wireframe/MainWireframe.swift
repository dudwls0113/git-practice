//
//  MainWireframe.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class MainWireframe: MainWireframeProtocol {
    
    static func createMainModule() -> BaseViewController {
        let view = MainViewController() as MainViewProtocol
        let presenter: MainPresenterProtocol & MainInteractorOutputProtocol & ReadingListInteractorOutputProtocol & StoryInteractorOutputProtocol = MainPresenter()
        let interactor: MainInteractorInputProtocol = MainInteractor()
        let readingListInteractor: ReadingListInteractorInputProtocol = ReadingListInteractor()
        var storyInteractor: StoryInteractorInputProtocol = StoryInteractor()
        let wireframe: MainWireframeProtocol = MainWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.readingListInteractor = readingListInteractor
        presenter.storyInteractor = storyInteractor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        readingListInteractor.presenter = presenter
        storyInteractor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func presentDetailStoryView(from view: UIViewController, story: Story) {
        let storyViewController = StoryWireframe.createStoryModule(story)
        view.navigationController?.pushViewController(storyViewController, animated: true)
    }
    
    func presentSearchView(from view: UIViewController) {
        view.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}
