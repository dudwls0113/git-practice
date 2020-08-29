//
//  ReadingListArchivedViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/14.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit

class ReadingListArchivedViewController: BaseViewController {
    
    var presenter: ReadingListPresenterProtocol?
    
    static let notification = Notification.Name("RefreshArchivedStories")
    
    var tableView: UITableView!
    
    var stories: [ReadingListStory] = []
    var pageNum: Int = 1
    let pageCnt: Int = 10
    
    override func viewDidLoad() {
        initialLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(initialLoad), name: ReadingListArchivedViewController.notification, object: nil)
        
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
        presenter?.getReadingList(readingType: .archive, pageNum: pageNum, pageCnt: pageCnt)
    }
    
    @objc func initialLoad() {
        showIndicator()
        pageNum = 1
        presenter?.getReadingList(readingType: .archive, pageNum: pageNum, pageCnt: pageCnt)
    }
}

extension ReadingListArchivedViewController: UITableViewDelegate, UITableViewDataSource {
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
}

extension ReadingListArchivedViewController: ReadingListViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func pressedBtn(_ indexPath: IndexPath) {
        if let readingListId = stories[indexPath.row].readingListId {
            presenter?.unarchiveStory(readingListId: readingListId, indexPath: indexPath)
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
//        stories[indexPath.row].readingType = .none
//        stories[indexPath.row].readingListId = nil
//        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func updateStoryArchived(_ indexPath: IndexPath) {
        //
    }
    
    func updateStoryUnarchived(_ indexPath: IndexPath) {
        stories.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        let notification = Notification(name: ReadingListRecentlyViewController.notification)
        NotificationCenter.default.post(notification)
    }
}

