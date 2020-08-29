//
//  SearchViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/14.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import SnapKit
import Alamofire

class SearchViewController: BaseViewController {
    
    var searchController: UISearchController!
    var swipeMenuView: SwipeMenuView!
    var tableView: UITableView!
    
    let searchStoryViewController = SearchStoryViewController()
    let searchPeopleViewController = SearchPeopleViewController()
        
    static let searchNewStoriesNotification = Notification.Name("SearchNewStories")
//    static let searchMoreStoriesNotification = Notification.Name("SearchMoreStories")
    static let searchNewPeopleNotification = Notification.Name("SearchNewPeople")

    override func viewDidLoad() {

        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for stories, authors, and tags"
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.title = nil
        
        swipeMenuView = SwipeMenuView(frame: view.frame)
        
        swipeMenuView.delegate = self
        swipeMenuView.dataSource = self
        view.addSubview(swipeMenuView)
        
        swipeMenuView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.itemView.margin = 10.0
        options.tabView.itemView.font = UIFont(name: "Helvetica", size: 13.5)!
        options.tabView.itemView.textColor = .gray
        options.tabView.additionView.padding = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        swipeMenuView.reloadData(options: options)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func getSearchStories(pageNum: Int, pageCnt: Int, searchText: String) {
        var url: String = "\(AppDelegate.baseUrl)/story/search"
        url += "?" + "pageNum=\(pageNum)"
        url += "&" + "pageCnt=\(pageCnt)"
        url += "&" + "search=\(searchText.lowercased())"
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let stories = self.jsonToStories(response.result.value) {
                        let notification = Notification(name: SearchViewController.searchNewStoriesNotification, object: nil, userInfo: ["stories":stories])
                        NotificationCenter.default.post(notification)
                    }
                case .failure:
                    break
                }
                self.dismissIndicator()
        }
    }
    
    func getSearchPeople(pageNum: Int, pageCnt: Int, searchText: String) {
        var url: String = "\(AppDelegate.baseUrl)/user/search"
        url += "?" + "pageNum=\(pageNum)"
        url += "&" + "pageCnt=\(pageCnt)"
        url += "&" + "search=\(searchText.lowercased())"
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let users = self.jsonToUsers(response.result.value) {
                        let notification = Notification(name: SearchViewController.searchNewPeopleNotification, object: nil, userInfo: ["users":users])
                        NotificationCenter.default.post(notification)
                    }
                case .failure:
                    break
                }
                self.dismissIndicator()
        }
    }
    
    func jsonToStories(_ json: Any?) -> [ProfileStory]? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? [[String : Any]] {
                var stories: [ProfileStory] = []
                for storyData in result {
                    guard let storyId   = storyData["storyId"]   as? Int     else { return nil }
                    guard let name      = storyData["name"]      as? String  else { return nil }
                    guard let title     = storyData["title"]     as? String  else { return nil }
                    let subTitle        = (storyData["subTitle"] as? String?) ?? nil
                    let readingListId   = (storyData["readingListId"] as? Int?) ?? nil
                    let publication     = (storyData["publication"] as? String?) ?? nil
                    let readingTypeTemp = (storyData["readingType"] as? String) ?? "none"
                    guard let createAt  = storyData["createAt"] as? String else { return nil }
                    let text            = (storyData["text"]     as? String?) ?? nil
                    let imageUrlAddr    = (storyData["image"]    as? String?) ?? nil
                    
                    guard let readingType = ReadingType(rawValue: readingTypeTemp) else { return nil }
                    let timeToRead: Int = (text != nil) ? (text!.count % 100) + 1 : Int(arc4random_uniform(19) + 1)
                    let createDate: Date = Date(detailString: createAt)
                    
                    let story = ProfileStory(id: storyId, readingListId: readingListId, title: title, contents: subTitle ?? text, author: name, publication: publication, timeToRead: timeToRead, storyImageUrlAddr: imageUrlAddr, createdDate: createDate, readingType: readingType)
                    
                    stories.append(story)
                }
                return stories
            }
        }
        return nil
    }
    
    func jsonToUsers(_ json: Any?) -> [User]? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? [[String : Any]] {
                var users: [User] = []
                for storyData in result {
                    guard let userId = storyData["userId"]    as? Int     else { return nil }
                    guard let name   = storyData["name"]      as? String  else { return nil }
                    let about        = (storyData["about"]    as? String?) ?? nil
                    let image        = (storyData["image"]    as? String?) ?? nil
                    let isFollow     = (storyData["isFollow"] as? Int)     ?? 0
                    
                    let user = User(userId: userId, name: name, about: about?.trimmingCharacters(in: [" ", "\n", "\r"]), imageUrlAddr: image?.trimmingCharacters(in: [" ", "\n", "\r"]), isFollow: isFollow)
                    users.append(user)
                }
                return users
            }
        }
        return nil
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if text.count > 0 {
                getSearchStories(pageNum: 1, pageCnt: 10, searchText: text)
                getSearchPeople(pageNum: 1, pageCnt: 10, searchText: text)
            } else {
                let notification1 = Notification(name: SearchViewController.searchNewPeopleNotification, object: nil, userInfo: ["users":[]])
                NotificationCenter.default.post(notification1)
                let notification2 = Notification(name: SearchViewController.searchNewStoriesNotification, object: nil, userInfo: ["stories":[]])
                NotificationCenter.default.post(notification2)            }
        }
    }
}

extension SearchViewController: SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        switch index {
        case 0: return searchStoryViewController
        case 1: return searchPeopleViewController
        default: return UIViewController()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        switch index {
        case 0: return "Stories"
        case 1: return "People"
        case 2: return "Tags"
        default: return ""
        }
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 2
    }
}
