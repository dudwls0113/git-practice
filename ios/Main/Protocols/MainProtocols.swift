//
//  MainProtocols.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    
    var dailyReadStories: [DailyReadStory] { get set }
    var recommendationStories: [RecommendationStory] { get set }
    
    func showLoading()
    func hideLoading()
    func showDailyReadStories(_ stories: [DailyReadStory])
    func showRocommendationStories(_ stories: [RecommendationStory])
    func finishRefresh()
    func updateStoryRead(_ indexPath: IndexPath)
    func updateStorySaved(_ indexPath: IndexPath, readingListId: Int)
    func updateStoryUnsaved(_ indexPath: IndexPath)
    func showAlert(_ message: String)
    
    // TABLE VIEW CELL -> VIEW
    func pressedSaveBtn(_ indexPath: IndexPath)
    func pressedMoreBtn(_ indexPath: IndexPath)
}

// VIEW -> PRESENTER
protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var readingListInteractor: ReadingListInteractorInputProtocol? { get set }
    var storyInteractor: StoryInteractorInputProtocol? { get set }
    var wireframe: MainWireframeProtocol? { get set }
    
    func viewDidLoad()
    func getMoreRecommendationStories(pageNum: Int, pageCnt: Int)
    func selectStory(indexPath: IndexPath, storyId: Int)
    func saveStory(indexPath: IndexPath, storyId: Int)
    func unsaveStory(indexPath: IndexPath, readingListId: Int)
    func searchStories()
}

// INTERACTOR -> PRESENTER
protocol MainInteractorOutputProtocol: class {
    func didRetrieveDailyReadStories(_ stories: [DailyReadStory]?)
    func didRetrieveRecommendationStories(_ stories: [RecommendationStory]?)
}

// PRESENTER -> INTERACTOR
protocol MainInteractorInputProtocol: class {
    var presenter: MainInteractorOutputProtocol? { get set }
    
    func retrieveDailyReadStories()
    func retrieveRecommendationStories(pageNum: Int, pageCnt: Int)
}

// PRESENER -> WIREFRAME
protocol MainWireframeProtocol: class {    
    static func createMainModule() -> BaseViewController
    
    func presentDetailStoryView(from view: UIViewController, story: Story)
    func presentSearchView(from view: UIViewController)
}
