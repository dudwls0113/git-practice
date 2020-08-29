//
//  ReadingListPresenter.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/13.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ReadingListPresenter: ReadingListPresenterProtocol {
    
    var view: ReadingListViewProtocol?
    var rootView: UIViewController?
    var interactor: ReadingListInteractorInputProtocol?
    var storyInteractor: StoryInteractorInputProtocol?
    var wireframe: ReadingListWireframeProtocol?
    
    func getReadingList(readingType: ReadingType, pageNum: Int, pageCnt: Int) {
        interactor?.requestReadingList(readingType: readingType, pageNum: pageNum, pageCnt: pageCnt)
    }
    
    func getRecentlyStories(pageNum: Int, pageCnt: Int) {
        interactor?.requestRecentlyStories(pageNum: pageNum, pageCnt: pageCnt)
    }
    
    func saveStory(storyId: Int, indexPath: IndexPath) {
        view?.showLoading()
        interactor?.requestSaveStory(storyId: storyId, indexPath: indexPath)
    }
    
    func unsaveStory(readingListId: Int, indexPath: IndexPath) {
        view?.showLoading()
        interactor?.requestUnsaveStory(readingListId: readingListId, indexPath: indexPath)
    }
    
    func archiveStory(readingListId: Int, indexPath: IndexPath) {
        view?.showLoading()
        interactor?.requestArchiveStory(readingListId: readingListId, indexPath: indexPath)
    }
    
    func unarchiveStory(readingListId: Int, indexPath: IndexPath) {
        view?.showLoading()
        interactor?.requestUnarchiveStory(readingListId: readingListId, indexPath: indexPath)
    }
    
    func pressedStory(_ storyId: Int) {
        view?.showLoading()
        storyInteractor?.requestStory(storyId)
    }
}

extension ReadingListPresenter: ReadingListInteractorOutputProtocol {
    func didRetrieveReadingList(_ stories: [ReadingListStory]?) {
        view?.hideLoading()
        if let stories = stories {
            view?.updateStories(stories)
        } else {
            view?.showAlert("Failed to get stories")
        }
    }
    
    func didRetrieveRecentlyStories(_ stories: [ReadingListStory]?) {
        view?.hideLoading()
        if let stories = stories {
            view?.updateStories(stories)
        } else {
            view?.showAlert("Failed to get stories")
        }
    }
    
    func didSaveStory(readingListId: Int?, indexPath: IndexPath) {
        view?.hideLoading()
        if let readingListId = readingListId {
            view?.updateStorySaved(indexPath, readingListId: readingListId)
        } else {
            view?.showAlert("Failed to save story.")
        }
    }
    
    func didUnsaveStory(isSuccessful: Bool, indexPath: IndexPath) {
        view?.hideLoading()
        if isSuccessful {
            view?.updateStoryUnsaved(indexPath)
        } else {
            view?.showAlert("Failed to unsave story.")
        }
    }
    
    func didArchiveStory(isSuccessful: Bool, indexPath: IndexPath) {
        view?.hideLoading()
        if isSuccessful {
            view?.updateStoryArchived(indexPath)
        } else {
            view?.showAlert("Failed to archive story.")
        }
    }
    
    func didUnarchiveStory(isSuccessful: Bool, indexPath: IndexPath) {
        view?.hideLoading()
        if isSuccessful {
            view?.updateStoryUnarchived(indexPath)
        } else {
            view?.showAlert("Failed to unarchive story.")
        }
    }
}

extension ReadingListPresenter: StoryInteractorOutputProtocol {
    
    func didRetrieveStory(_ story: Story?) {
        view?.hideLoading()
        if let story = story {
//                print(view.navigationController.pop)
            wireframe?.presentDetailStoryView(from: view! as! UIViewController, story: story)
//            wireframe?.presentDetailStoryView(from: ((view as! UIViewController).navigationController?.popViewController(animated: false))!, story: story)
        } else {
            view?.showAlert("Failed to get story data.")
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
}
