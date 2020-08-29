//
//  ReadingListProtocols.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/13.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol ReadingListViewProtocol: class {
    var presenter: ReadingListPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showAlert(_ message: String)
    func updateStories(_ stories: [ReadingListStory])
    func updateStorySaved(_ indexPath: IndexPath, readingListId: Int)
    func updateStoryUnsaved(_ indexPath: IndexPath)
    func updateStoryArchived(_ indexPath: IndexPath)
    func updateStoryUnarchived(_ indexPath: IndexPath)
    
    // CELL -> VIEW
    func pressedBtn(_ indexPath: IndexPath)
}

// VIEW -> PRESENTER
protocol ReadingListPresenterProtocol: class {
    var view: ReadingListViewProtocol? { get set }
    var rootView: UIViewController? { get set }
    var interactor: ReadingListInteractorInputProtocol? { get set }
    var storyInteractor: StoryInteractorInputProtocol? { get set }
    var wireframe: ReadingListWireframeProtocol? { get set }
    
    func getReadingList(readingType: ReadingType, pageNum: Int, pageCnt: Int)
    func getRecentlyStories(pageNum: Int, pageCnt: Int)
    func saveStory(storyId: Int, indexPath: IndexPath)
    func unsaveStory(readingListId: Int, indexPath: IndexPath)
    func archiveStory(readingListId: Int, indexPath: IndexPath)
    func unarchiveStory(readingListId: Int, indexPath: IndexPath)
    func pressedStory(_ storyId: Int)
}

// INTERACTOR -> PRESENTER
protocol ReadingListInteractorOutputProtocol: class {
    func didRetrieveReadingList(_ stories: [ReadingListStory]?)
    func didRetrieveRecentlyStories(_ stories: [ReadingListStory]?)
    func didSaveStory(readingListId: Int?, indexPath: IndexPath)
    func didUnsaveStory(isSuccessful: Bool, indexPath: IndexPath)
    func didArchiveStory(isSuccessful: Bool, indexPath: IndexPath)
    func didUnarchiveStory(isSuccessful: Bool, indexPath: IndexPath)
}

// PRESENTER -> INTERACTOR
protocol ReadingListInteractorInputProtocol: class {
    var presenter: ReadingListInteractorOutputProtocol? { get set }
    
    func requestReadingList(readingType: ReadingType, pageNum: Int, pageCnt: Int)
    func requestRecentlyStories(pageNum: Int, pageCnt: Int)
    func requestSaveStory(storyId: Int, indexPath: IndexPath)
    func requestUnsaveStory(readingListId: Int, indexPath: IndexPath)
    func requestArchiveStory(readingListId: Int, indexPath: IndexPath)
    func requestUnarchiveStory(readingListId: Int, indexPath: IndexPath)
}

// PRESENER -> WIREFRAME
protocol ReadingListWireframeProtocol: class {
    static func createReadingListModule() -> BaseViewController
    static func createReadingListSavedModule(from rootView: UIViewController) -> BaseViewController
    static func createReadingListArchiveModule(from rootView: UIViewController) -> BaseViewController
    static func createReadingListRecentlyModule(from rootView: UIViewController) -> BaseViewController
    
    func presentDetailStoryView(from view: UIViewController, story: Story)
}
