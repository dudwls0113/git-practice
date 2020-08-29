//
//  MainPresenter.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
    
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var readingListInteractor: ReadingListInteractorInputProtocol?
    var storyInteractor: StoryInteractorInputProtocol?
    var wireframe: MainWireframeProtocol?
    
    var indexPath: IndexPath?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveDailyReadStories()
        interactor?.retrieveRecommendationStories(pageNum: 1, pageCnt: 10)
    }
    
    func getMoreRecommendationStories(pageNum: Int, pageCnt: Int) {
        interactor?.retrieveRecommendationStories(pageNum: pageNum, pageCnt: pageCnt)
    }
    
    func selectStory(indexPath: IndexPath, storyId: Int) {
        self.indexPath = indexPath
        storyInteractor?.requestStory(storyId)
    }
    
    func saveStory(indexPath: IndexPath, storyId: Int) {
        readingListInteractor?.requestSaveStory(storyId: storyId, indexPath: indexPath)
    }
    
    func unsaveStory(indexPath: IndexPath, readingListId: Int) {
        readingListInteractor?.requestUnsaveStory(readingListId: readingListId, indexPath: indexPath)
    }
    
    func searchStories() {
        wireframe?.presentSearchView(from: view! as! UIViewController)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func didRetrieveDailyReadStories(_ stories: [DailyReadStory]?) {
        if (view?.recommendationStories.count)! > 0 {
            view?.hideLoading()
            view?.finishRefresh()
        }
        view?.showDailyReadStories(stories ?? DailyReadStory.getDummy())
    }
    
    func didRetrieveRecommendationStories(_ stories: [RecommendationStory]?) {
        if (view?.dailyReadStories.count)! > 0 {
            view?.hideLoading()
            view?.finishRefresh()
        }
        view?.showRocommendationStories(stories ?? RecommendationStory.getDummy())
    }
}

extension MainPresenter: ReadingListInteractorOutputProtocol {
    
    func didSaveStory(readingListId: Int?, indexPath: IndexPath) {
        if let readingListId = readingListId {
            view?.updateStorySaved(indexPath, readingListId: readingListId)
        } else {
            view?.showAlert("Failed to save the story.")
        }
    }
    
    func didUnsaveStory(isSuccessful: Bool, indexPath: IndexPath) {
        if isSuccessful {
            view?.updateStoryUnsaved(indexPath)
        } else {
            view?.showAlert("Failed to unsave the story.")
        }
    }
    
    func didRetrieveReadingList(_ stories: [ReadingListStory]?) {
        //
    }
    
    func didRetrieveRecentlyStories(_ stories: [ReadingListStory]?) {
        //
    }
    
    func didArchiveStory(isSuccessful: Bool, indexPath: IndexPath) {
        //
    }
    
    func didUnarchiveStory(isSuccessful: Bool, indexPath: IndexPath) {
        //
    }
}

extension MainPresenter: StoryInteractorOutputProtocol {
    func didRetrieveStory(_ story: Story?) {
        if let story = story {
            wireframe?.presentDetailStoryView(from: view! as! UIViewController, story: story)
        } else {
            view?.showAlert("Failed to retreive story data.")
        }
    }
    
    func didHighlightStory(_ contentsId: Int?) {
        //
    }
    
    func didUnhighlightStory(_ contentsId: Int?) {
        //
    }
    
    func didClapStory(_ isSuccessful: Bool) {
        //
    }
    
    func didSaveStory(_ readingListId: Int?) {
        //
    }
    
    func didUnsaveStory(_ isSuccessful: Bool?) {
        //
    }
    
}
