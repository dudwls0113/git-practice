//
//  StoryProtocols.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

// PRESENTER -> VIEW
protocol StoryViewProrotol {
    var presenter: StoryPresenterProtocol? { get set }
    
    func setStory(_ story: Story)
    func setClap()
    func setSaved(_ readingListId: Int)
    func setUnsaved()
    func setStoryHighlight(_ contentsId: Int)
    func setStoryUnhighlight(_ contentsId: Int)
    func showAlert(_ message: String)
}

// VIEW -> PRESENTER
protocol StoryPresenterProtocol {
    var view: StoryViewProrotol? { get set }
    var interactor: StoryInteractorInputProtocol? { get set }
    var readingListInteractor: ReadingListInteractorInputProtocol? { get set }
    var wireframe: StoryWireframeProtocol? { get set }
    
    func highlightStory(storyId: Int, contentsId: Int)
    func unhighlightStory(storyId: Int, contentsId: Int)
    func clapStory(_ storyId: Int)
    func saveStory(_ storyId: Int)
    func unsaveStory(_ readingListId: Int)
}

// INTERACTOR -> PRESENTER
protocol StoryInteractorOutputProtocol {
    func didRetrieveStory(_ story: Story?)
    func didHighlightStory(_ contentsId: Int?)
    func didUnhighlightStory(_ contentsId: Int?)
    func didClapStory(_ isSuccessful: Bool)
}

// PRESENTER -> INTERACTOR
protocol StoryInteractorInputProtocol {
    var presenter: StoryInteractorOutputProtocol? { get set }
    
    func requestHighlightStory(storyId: Int, contentsId: Int)
    func requestUnhighlightStory(storyId: Int, contentsId: Int)
    func requestStory(_ storyId: Int)
    func requestClapStory(_ storyId: Int)
}

// PRESENTER -> WIREFRAME
protocol StoryWireframeProtocol {
    static func createStoryModule(_ story: Story) -> BaseViewController
}
