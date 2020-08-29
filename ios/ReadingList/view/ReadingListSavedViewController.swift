//
//  ReadingListSavedViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/12.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit

class ReadingListSavedViewController: BaseViewController {
    
    var presenter: ReadingListPresenterProtocol?
    
    static let notification = Notification.Name("RefreshSavedStories")
    
    var tableView: UITableView!
    
    var stories: [ReadingListStory] = []
    var pageNum: Int = 1
    let pageCnt: Int = 10
    
    override func viewDidLoad() {
        initialLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(initialLoad), name: ReadingListSavedViewController.notification, object: nil)
        
        tableView = UITableView(frame: view.frame, style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.top.equalTo(0)
            make.bottom.bottom.equalTo(0)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        let cell = UINib(nibName: "ReadingListStoryCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: ReadingListStoryCell.cellReuseIdentifier)
    }
    
    @objc func refresh() {
        pageNum = 1
        presenter?.getReadingList(readingType: .save, pageNum: pageNum, pageCnt: pageCnt)
    }
    
    @objc func initialLoad() {
        showIndicator()
        pageNum = 1
        presenter?.getReadingList(readingType: .save, pageNum: pageNum, pageCnt: pageCnt)
    }
}

extension ReadingListSavedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReadingListStoryCell.cellReuseIdentifier) as? ReadingListStoryCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == stories.count - 5 && stories.count == (pageNum - 1) * pageCnt {
            presenter?.getReadingList(readingType: .save, pageNum: pageNum, pageCnt: pageCnt)
        }
        
        cell.updateUI(story: stories[indexPath.row], isSaved: true, view: self, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pressedStory(stories[indexPath.row].storyId)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Unsave") { action, view, success in
            if let readingListId = self.stories[indexPath.row].readingListId {
                self.presenter?.unsaveStory(readingListId: readingListId, indexPath: indexPath)
            } else {
                self.showAlert("Failed to unsave the story.")
            }
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "bookmark.fill")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ReadingListSavedViewController: ReadingListViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func pressedBtn(_ indexPath: IndexPath) {
        if let readingListId = stories[indexPath.row].readingListId {
             presenter?.archiveStory(readingListId: readingListId, indexPath: indexPath)
        } else {
            showAlert("Failed to archiveStory")
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateStories(_ stories: [ReadingListStory]) {
        if pageNum == 1 {
            self.stories = stories
            tableView.refreshControl?.endRefreshing()
        } else {
            self.stories += stories
        }
        pageNum += 1
        tableView.reloadData()
    }
    
    func updateStorySaved(_ indexPath: IndexPath, readingListId: Int) {
//        stories[indexPath.row].readingType = .save
//        stories[indexPath.row].readingListId = readingListId
//        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func updateStoryUnsaved(_ indexPath: IndexPath) {
        stories[indexPath.row].readingType = .none
        stories[indexPath.row].readingListId = nil
        tableView.reloadRows(at: [indexPath], with: .none)
        let notification = Notification(name: ReadingListRecentlyViewController.notification)
        NotificationCenter.default.post(notification)
    }
    
    func updateStoryArchived(_ indexPath: IndexPath) {
        stories.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        let notification1 = Notification(name: ReadingListArchivedViewController.notification)
        NotificationCenter.default.post(notification1)
        let notification2 = Notification(name: ReadingListRecentlyViewController.notification)
        NotificationCenter.default.post(notification2)
    }
    
    func updateStoryUnarchived(_ indexPath: IndexPath) {
        //
    }
}
