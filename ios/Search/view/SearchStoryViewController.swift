//
//  SearchStoryViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/14.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit

class SearchStoryViewController: BaseViewController {
    
    var presenter: ReadingListPresenterProtocol?
    
    var tableView: UITableView!
    
    var stories: [ProfileStory] = []
    
    override func viewDidLoad() {
        presenter = ReadingListPresenter()
        let interactor = ReadingListInteractor()
        let storyInteractor = StoryInteractor()
        let wireframe = ReadingListWireframe()
        presenter?.view = self
        presenter?.interactor = interactor
        presenter?.storyInteractor = storyInteractor
        presenter?.wireframe = wireframe
        interactor.presenter = (presenter as! ReadingListInteractorOutputProtocol)
        storyInteractor.presenter = (presenter as! StoryInteractorOutputProtocol)
        
        tableView = UITableView(frame: view.frame, style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNewStories), name: SearchViewController.searchNewStoriesNotification, object: nil)
        
        let cell = UINib(nibName: "ProfileStoryCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: ProfileStoryCell.cellReuseIdentifier)
    }
    
    @objc func setNewStories(_ notification: Notification) {
        if let stories = notification.userInfo?["stories"] as? [ProfileStory] {
            self.stories = stories
            tableView.reloadData()
        }
    }
}

extension SearchStoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileStoryCell.cellReuseIdentifier) as? ProfileStoryCell {
            cell.updateUI(story: stories[indexPath.row], view: self, indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.pressedStory(stories[indexPath.row].id)
    }
}

extension SearchStoryViewController: ReadingListViewProtocol {
    func showLoading() {
        showIndicator()
    }
   
    func hideLoading() {
        dismissIndicator()
    }
   
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
   
    func updateStories(_ stories: [ReadingListStory]) {
        //
    }
   
    func updateStorySaved(_ indexPath: IndexPath, readingListId: Int) {
        stories[indexPath.row].readingListId = readingListId
        stories[indexPath.row].readingType = .save
        tableView.reloadRows(at: [indexPath], with: .none)
    }
   
    func updateStoryUnsaved(_ indexPath: IndexPath) {
       //
    }
   
    func updateStoryArchived(_ indexPath: IndexPath) {
        stories[indexPath.row].readingType = .archive
        tableView.reloadRows(at: [indexPath], with: .none)
    }
   
    func updateStoryUnarchived(_ indexPath: IndexPath) {
        stories[indexPath.row].readingListId = nil
        stories[indexPath.row].readingType = .none
        tableView.reloadRows(at: [indexPath], with: .none)
    }
   
    func pressedBtn(_ indexPath: IndexPath) {
        let story = stories[indexPath.row]
        switch story.readingType {
        case .save:
            if let readingListId = story.readingListId {
                presenter?.archiveStory(readingListId: readingListId, indexPath: indexPath)
            } else {
                showAlert("Failed to archive the story.")
            }
        case .archive:
            if let readingListId = story.readingListId {
                presenter?.unarchiveStory(readingListId: readingListId, indexPath: indexPath)
            } else {
                showAlert("Failed to unarchive the story.")
            }
        case .none:
            if story.readingListId == nil {
                presenter?.saveStory(storyId: story.id, indexPath: indexPath)
            } else {
                showAlert("Failed to save the story.")
            }
        }
    }
}
