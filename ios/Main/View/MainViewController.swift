//
//  MainViewController.swift
//  Medium
//
//  Created by 윤영일 on 05/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    var presenter: MainPresenterProtocol?
    
    var dailyReadStories: [DailyReadStory] = []
    var recommendationStories: [RecommendationStory] = []
    
    var pageNum: Int = 1
    let pageCnt: Int = 10

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(pressedSearch))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let dailyReadTitleCell = UINib(nibName: "DailyReadTitleCell", bundle: nil)
        let dailyAlreadyReadTitleCell = UINib(nibName: "DailyAlreadyReadTitleCell", bundle: nil)
        let dailyReadCell = UINib(nibName: "DailyReadCell", bundle: nil)
        let dailyAlreadyReadCell = UINib(nibName: "DailyAlreadyReadCell", bundle: nil)
        let recommendationCell = UINib(nibName: "RecommendationCell", bundle: nil)
        
        tableView.register(dailyReadTitleCell, forCellReuseIdentifier: DailyReadTitleCell.cellReuseIdentifier)
        tableView.register(dailyAlreadyReadTitleCell, forCellReuseIdentifier: DailyAlreadyReadTitleCell.cellReuseIdentifier)
        tableView.register(dailyReadCell, forCellReuseIdentifier: DailyReadCell.cellReuseIdentifier)
        tableView.register(dailyAlreadyReadCell, forCellReuseIdentifier: DailyAlreadyReadCell.cellReuseIdentifier)
        tableView.register(recommendationCell, forCellReuseIdentifier: RecommendationCell.cellReuseIdentifier)
        
        presenter?.viewDidLoad()
    }
    
    func isAllRead() -> Bool {
        for story in dailyReadStories {
            if !story.isRead {
                return false
            }
        }
        return true
    }
    
    @objc func pressedSearch() {
        presenter?.searchStories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.allowsSelection = true
        navigationItem.title = "Medium"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Didot-Bold", size: 26)!]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dailyReadStories.count > 0 ? (1 + dailyReadStories.count) : 0
        case 1:
            return recommendationStories.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    @objc func refresh() {
        pageNum = 1
        presenter?.viewDidLoad()
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                if (indexPath.row == 0) && !isAllRead() {
                    return DailyReadTitleCell.height
                } else if (indexPath.row == 0) {
                    return DailyAlreadyReadTitleCell.height
                } else {
                    let story: DailyReadStory = dailyReadStories[indexPath.row - 1]
                    return story.isRead ? DailyAlreadyReadCell.height : DailyReadCell.height
                }
            } else if indexPath.section == 1 {
                return recommendationStories[indexPath.row].topic == nil ? RecommendationCell.heightWithoutTopic : RecommendationCell.heightWithTopic
            }
            return tableView.rowHeight
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            // 첫 줄, 아직 읽지 않은 글이 남아있을 때
            if (indexPath.row == 0 && !isAllRead()) {
                guard let dailyReadTitleCell = tableView.dequeueReusableCell(withIdentifier: DailyReadTitleCell.cellReuseIdentifier) as? DailyReadTitleCell else {
                    return UITableViewCell()
                }
                return dailyReadTitleCell
            }
            // 첫 줄, 모든 글을 다 읽었을 때
            else if (indexPath.row == 0) {
                guard let dailyAlreadyReadTitleCell = tableView.dequeueReusableCell(withIdentifier: DailyAlreadyReadTitleCell.cellReuseIdentifier) as? DailyAlreadyReadTitleCell else {
                    return UITableViewCell()
                }
                return dailyAlreadyReadTitleCell
            }
            // 게시글이 있는 Cell
            let story: DailyReadStory = dailyReadStories[indexPath.row - 1]
            if story.isRead {
                guard let dailyAlreadyReadCell = tableView.dequeueReusableCell(withIdentifier: DailyAlreadyReadCell.cellReuseIdentifier) as? DailyAlreadyReadCell else {
                    return UITableViewCell()
                }
                dailyAlreadyReadCell.hideSeparator()
                dailyAlreadyReadCell.updateUI(story)
                return dailyAlreadyReadCell
            } else {
                guard let dailyReadCell = tableView.dequeueReusableCell(withIdentifier: DailyReadCell.cellReuseIdentifier) as? DailyReadCell else {
                    return UITableViewCell()
                }
                dailyReadCell.hideSeparator()
                dailyReadCell.updateUI(story)
                return dailyReadCell
            }
        } else if indexPath.section == 1 {
            if indexPath.section == 1 && indexPath.row == recommendationStories.count - 5 && recommendationStories.count == (pageNum - 1) * pageCnt {
                presenter?.getMoreRecommendationStories(pageNum: pageNum, pageCnt: pageCnt)
            }
            
            let story: RecommendationStory = recommendationStories[indexPath.row]
            guard let recommendationCell = tableView.dequeueReusableCell(withIdentifier: RecommendationCell.cellReuseIdentifier) as? RecommendationCell else {
                return UITableViewCell()
            }
            recommendationCell.updateUI(story: story, view: self, indexPath: indexPath)
            return recommendationCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1..<(dailyReadStories.count + 1)):
            tableView.allowsSelection = false
            presenter?.selectStory(indexPath: indexPath, storyId: dailyReadStories[indexPath.row - 1].id)
            break
        case (1, 0..<recommendationStories.count):
            tableView.allowsSelection = false
            presenter?.selectStory(indexPath: indexPath, storyId: recommendationStories[indexPath.row].storyId)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section + indexPath.row > 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isSaved: Bool = (indexPath.section == 0) ? dailyReadStories[indexPath.row - 1].isSaved : recommendationStories[indexPath.row].isSaved
        let action = UIContextualAction(style: .normal, title: isSaved ? "Unsave" : "Save") { action, view, success in
            if isSaved {
                if let readingListId = (indexPath.section == 0) ? self.dailyReadStories[indexPath.row - 1].readingListId : self.recommendationStories[indexPath.row].readingListId {
                    self.showLoading()
                    self.presenter?.unsaveStory(indexPath: indexPath, readingListId: readingListId)
                }
                success(false)
            } else {
                self.showLoading()
                let storyId = (indexPath.section == 0) ? self.dailyReadStories[indexPath.row - 1].id : self.recommendationStories[indexPath.row].storyId
                self.presenter?.saveStory(indexPath: indexPath, storyId: storyId)
            }
        }
        action.backgroundColor = .moss
        action.image = UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark")
        return UISwipeActionsConfiguration(actions: [action])
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if indexPath.section + indexPath.row > 0 && editingStyle == . {
//            presenter?.saveStory(indexPath: indexPath, storyId: (indexPath.section == 0) ? dailyReadStories[indexPath.row - 1].id : recommendationStories[indexPath.row].storyId)
//        }
//    }
}

extension MainViewController: MainViewProtocol {
    
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func showDailyReadStories(_ stories: [DailyReadStory]) {
        dailyReadStories = stories
        if recommendationStories.count > 0 {
            tableView.reloadData()
        }
    }
    
    func showRocommendationStories(_ stories: [RecommendationStory]) {
        if pageNum == 1 {
            recommendationStories = stories
        } else {
            recommendationStories += stories
        }
        pageNum += 1
        if dailyReadStories.count > 0 {
            tableView.reloadData()
        }
    }
    
    func finishRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func showAlert(_ message: String) {
        hideLoading()
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            self.tableView.allowsSelection = true
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateStoryRead(_ indexPath: IndexPath) {
        hideLoading()
        if (indexPath.section == 0 && indexPath.row > 0 && indexPath.row <= dailyReadStories.count) {
            dailyReadStories[indexPath.row - 1].isRead = true
            if isAllRead() {
                tableView.reloadRows(at: [IndexPath(row: 0, section: 0), indexPath], with: .none)
            } else {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    func updateStorySaved(_ indexPath: IndexPath, readingListId: Int) {
        hideLoading()
        if (indexPath.section == 0 && indexPath.row > 0 && indexPath.row <= dailyReadStories.count) {
            dailyReadStories[indexPath.row - 1].isSaved = true
            dailyReadStories[indexPath.row - 1].readingListId = readingListId
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        if (indexPath.section == 1 && indexPath.row >= 0 && indexPath.row < recommendationStories.count) {
            recommendationStories[indexPath.row].isSaved = true
            recommendationStories[indexPath.row].readingListId = readingListId
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func updateStoryUnsaved(_ indexPath: IndexPath) {
        hideLoading()
        if (indexPath.section == 0 && indexPath.row > 0 && indexPath.row <= dailyReadStories.count) {
            dailyReadStories[indexPath.row - 1].isSaved = false
            dailyReadStories[indexPath.row - 1].readingListId = nil
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        else if (indexPath.section == 1 && indexPath.row >= 0 && indexPath.row < recommendationStories.count) {
            recommendationStories[indexPath.row].isSaved = false
            recommendationStories[indexPath.row].readingListId = nil
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func pressedSaveBtn(_ indexPath: IndexPath) {
        let story: RecommendationStory = recommendationStories[indexPath.row]
        if story.isSaved, let readingListId = story.readingListId {
            presenter?.unsaveStory(indexPath: indexPath, readingListId: readingListId)
        } else {
            presenter?.saveStory(indexPath: indexPath, storyId: story.storyId)
        }
    }
    
    func pressedMoreBtn(_ indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let fewerStoryAlert = UIAlertAction(title: "Show fewer stories like this", style: .default, handler: nil)
        alert.addAction(fewerStoryAlert)
        if let topic: String = recommendationStories[indexPath.row].topic {
            let fewerTopicAlert = UIAlertAction(title: "Show fewer stories from \(topic.upperCaseFirst())", style: .default, handler: nil)
            alert.addAction(fewerTopicAlert)
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAlert)
        self.present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }

    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
