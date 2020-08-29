//
//  StoryPresenter.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class StoryPresenter: StoryPresenterProtocol {
    
    var view: StoryViewProrotol?
    var interactor: StoryInteractorInputProtocol?
    var readingListInteractor: ReadingListInteractorInputProtocol?
    var wireframe: StoryWireframeProtocol?
    
    func highlightStory(storyId: Int, contentsId: Int) {
        interactor?.requestHighlightStory(storyId: storyId, contentsId: contentsId)
    }
    
    func unhighlightStory(storyId: Int, contentsId: Int) {
        interactor?.requestUnhighlightStory(storyId: storyId, contentsId: contentsId)
    }
    
    func clapStory(_ storyId: Int) {
        interactor?.requestClapStory(storyId)
    }
    
    func saveStory(_ storyId: Int) {
        readingListInteractor?.requestSaveStory(storyId: storyId, indexPath: IndexPath())
    }
    
    func unsaveStory(_ readingListId: Int) {
        readingListInteractor?.requestUnsaveStory(readingListId: readingListId, indexPath: IndexPath())
    }
}

extension StoryPresenter: StoryInteractorOutputProtocol {
    func didRetrieveStory(_ story: Story?) {
        if let story = story {
            view?.setStory(story)
        } else {
            view?.showAlert("Failed to get story.")
        }
    }
    
    func didHighlightStory(_ contentsId: Int?) {
        if let contentsId = contentsId {
            view?.setStoryHighlight(contentsId)
        } else {
            view?.showAlert("Failed to highlight the text.")
        }
    }
    
    func didUnhighlightStory(_ contentsId: Int?) {
        if let contentsId = contentsId {
            view?.setStoryUnhighlight(contentsId)
        } else {
            view?.showAlert("Failed th highlight the text.")
        }
    }
    
    func didClapStory(_ isSuccessful: Bool) {
        if isSuccessful {
            view?.setClap()
        } else {
            view?.showAlert("Failed to clap.")
        }
    }
}

extension StoryPresenter: ReadingListInteractorOutputProtocol {
    
    func didSaveStory(readingListId: Int?, indexPath: IndexPath) {
        if let readingListId = readingListId {
            view?.setSaved(readingListId)
        } else {
            view?.showAlert("Failed to save the story.")
        }
    }
    
    func didUnsaveStory(isSuccessful: Bool, indexPath: IndexPath) {
        if isSuccessful {
            view?.setUnsaved()
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
