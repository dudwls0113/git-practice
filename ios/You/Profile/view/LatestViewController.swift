//
//  LatestViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class LatestViewController: BaseViewController {
    
    var presenter: ReadingListPresenterProtocol?
    
    var tableView: UITableView!
    
    var stories: [ProfileStory] = ProfileStory.getDummy()
    
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
            make.top.top.equalTo(0)
            make.bottom.bottom.equalTo(0)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        let cell = UINib(nibName: "ProfileStoryCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: ProfileStoryCell.cellReuseIdentifier)
        
        showIndicator()
        getLatestStories(pageNum: 1, pageCnt: 10)
    }
    
    func getLatestStories(pageNum: Int, pageCnt: Int) {
//        var url: String = "\(AppDelegate.baseUrl)/user/\(7)/story"
//        url += "?" + "pageNum=\(pageNum)"
//        url += "&" + "pageCnt=\(pageCnt)"
        Alamofire
            .request("\(AppDelegate.baseUrl)/user/\(7)/story", method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.stories = self.jsonToStories(response.result.value) ?? ProfileStory.getDummy()
                case .failure:
                    self.stories = ProfileStory.getDummy()
                }
                self.tableView.reloadData()
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
}

extension LatestViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProfileStoryCell.height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Latest"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = .boldSystemFont(ofSize: 16)
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

extension LatestViewController: ReadingListViewProtocol {
    
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
