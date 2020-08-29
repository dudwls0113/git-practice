//
//  StoryWireframe.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

class StoryWireframe: StoryWireframeProtocol {
    
    static func createStoryModule(_ story: Story) -> BaseViewController {
        var view: StoryViewProrotol = StoryViewController()
        var presenter: StoryPresenterProtocol & StoryInteractorOutputProtocol & ReadingListInteractorOutputProtocol = StoryPresenter()
        var interactor: StoryInteractorInputProtocol = StoryInteractor()
        let readingListInteractor: ReadingListInteractorInputProtocol = ReadingListInteractor()
        let wireframe: StoryWireframeProtocol = StoryWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.readingListInteractor = readingListInteractor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        readingListInteractor.presenter = presenter
        
        view.setStory(story)
        
        return view as! BaseViewController
    }
}
