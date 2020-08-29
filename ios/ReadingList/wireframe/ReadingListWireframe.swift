//
//  ReadingListWireframe.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/14.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ReadingListWireframe: ReadingListWireframeProtocol {
    
    static func createReadingListModule() -> BaseViewController {
        return ReadingListViewController()
    }
    
    static func createReadingListSavedModule(from rootView: UIViewController) -> BaseViewController {
        let view: ReadingListViewProtocol = ReadingListSavedViewController()
        let presenter: ReadingListPresenterProtocol & ReadingListInteractorOutputProtocol & StoryInteractorOutputProtocol = ReadingListPresenter()
        let interactor: ReadingListInteractorInputProtocol = ReadingListInteractor()
        var storyInteractor: StoryInteractorInputProtocol = StoryInteractor()
        let wireframe: ReadingListWireframeProtocol = ReadingListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.rootView = rootView
        presenter.interactor = interactor
        presenter.storyInteractor = storyInteractor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        storyInteractor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    static func createReadingListArchiveModule(from rootView: UIViewController) -> BaseViewController {
        let view: ReadingListViewProtocol = ReadingListArchivedViewController()
        let presenter: ReadingListPresenterProtocol & ReadingListInteractorOutputProtocol = ReadingListPresenter()
        let interactor: ReadingListInteractorInputProtocol = ReadingListInteractor()
        let wireframe: ReadingListWireframeProtocol = ReadingListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.rootView = rootView
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    static func createReadingListRecentlyModule(from rootView: UIViewController) -> BaseViewController {
        let view: ReadingListViewProtocol = ReadingListRecentlyViewController()
        let presenter: ReadingListPresenterProtocol & ReadingListInteractorOutputProtocol = ReadingListPresenter()
        let interactor: ReadingListInteractorInputProtocol = ReadingListInteractor()
        let wireframe: ReadingListWireframeProtocol = ReadingListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.rootView = rootView
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return view as! BaseViewController
    }
    
    func presentDetailStoryView(from view: UIViewController, story: Story) {
        let storyViewController = StoryWireframe.createStoryModule(story)
        view.present(storyViewController, animated: true, completion: nil)
    }
}
