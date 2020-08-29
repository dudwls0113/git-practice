//
//  ReadingListInteractor.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/13.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Alamofire

class ReadingListInteractor: ReadingListInteractorInputProtocol {
    
    var presenter: ReadingListInteractorOutputProtocol?
    
    func requestReadingList(readingType: ReadingType, pageNum: Int, pageCnt: Int) {
        var url: String = "\(AppDelegate.baseUrl)/readinglist"
        url += "?" + "type=\(readingType.rawValue)"
        url += "&" + "pageNum=\(pageNum)"
        url += "&" + "pageCnt=\(pageCnt)"
        
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let stories = self.jsonToReadingListStories(response.result.value) {
                        self.presenter?.didRetrieveReadingList(stories)
                    } else {
                        self.presenter?.didRetrieveReadingList(nil)
                    }
                case .failure:
                    self.presenter?.didRetrieveReadingList(nil)
                }
        }
    }
    
    func requestRecentlyStories(pageNum: Int, pageCnt: Int) {
        var url: String = "\(AppDelegate.baseUrl)/recentlylist"
        url += "?" + "pageNum=\(pageNum)"
        url += "&" + "pageCnt=\(pageCnt)"
        
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let stories = self.jsonToRecentlyStories(response.result.value) {
                        self.presenter?.didRetrieveRecentlyStories(stories)
                    } else {
                        self.presenter?.didRetrieveRecentlyStories(nil)
                    }
                case .failure:
                    self.presenter?.didRetrieveRecentlyStories(nil)
                }
        }
    }
    
    func requestSaveStory(storyId: Int, indexPath: IndexPath) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/readinglist", method: .post, parameters: Parameters(dictionaryLiteral: ("storyId", storyId)), encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let readingListId = data["readingListId"] as? Int {
                            self.presenter?.didSaveStory(readingListId: readingListId, indexPath: indexPath)
                            break
                        }
                    }
                    self.presenter?.didSaveStory(readingListId: nil, indexPath: indexPath)
                case .failure:
                    self.presenter?.didSaveStory(readingListId: nil, indexPath: indexPath)
                }
        }
    }
    
    func requestUnsaveStory(readingListId: Int, indexPath: IndexPath) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/readinglist/\(readingListId)", method: .delete, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let isSuccess = data["isSuccess"] as? Bool {
                            self.presenter?.didUnsaveStory(isSuccessful: isSuccess, indexPath: indexPath)
                            break
                        }
                    }
                    self.presenter?.didUnsaveStory(isSuccessful: false, indexPath: indexPath)
                case .failure:
                    self.presenter?.didUnsaveStory(isSuccessful: false, indexPath: indexPath)
                }
        }
    }
    
    func requestArchiveStory(readingListId: Int, indexPath: IndexPath) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/readinglist/\(readingListId)", method: .patch, parameters: Parameters(dictionaryLiteral: ("readingListId", readingListId)), encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let isSuccess = data["isSuccess"] as? Bool {
                            self.presenter?.didArchiveStory(isSuccessful: isSuccess, indexPath: indexPath)
                            break
                        }
                    }
                    self.presenter?.didArchiveStory(isSuccessful: false, indexPath: indexPath)
                case .failure:
                    self.presenter?.didArchiveStory(isSuccessful: false, indexPath: indexPath)
                }
        }
    }
    
    func requestUnarchiveStory(readingListId: Int, indexPath: IndexPath) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/readinglist/\(readingListId)", method: .delete, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let isSuccess = data["isSuccess"] as? Bool {
                            self.presenter?.didUnarchiveStory(isSuccessful: isSuccess, indexPath: indexPath)
                            break
                        }
                    }
                    self.presenter?.didUnarchiveStory(isSuccessful: false, indexPath: indexPath)
                case .failure:
                    self.presenter?.didUnarchiveStory(isSuccessful: false, indexPath: indexPath)
                }
        }
    }
    
    func jsonToReadingListStories(_ json: Any?) -> [ReadingListStory]? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? [[String : Any]] {
                var stories: [ReadingListStory] = []
                for storyData in result {
                    guard let storyId   = storyData["storyId"]   as? Int     else { return nil }
                    guard let userId    = storyData["userId"]    as? Int     else { return nil }
                    guard let name      = storyData["name"]      as? String  else { return nil }
                    guard let title     = storyData["title"]     as? String  else { return nil }
                    let subTitle        = (storyData["subTitle"] as? String?) ?? nil
                    guard let readingListId = storyData["readingListId"] as? Int else { return nil }
                    guard let readingTypeTemp = storyData["readingType"] as? String else { return nil }
                    let publicationId   = (storyData["publicationId"] as? Int?) ?? nil
                    let publications     = (storyData["publications"] as? String?) ?? nil
                    guard let createAt  = storyData["createAt"] as? String else { return nil }
                    let text            = (storyData["text"]     as? String?) ?? nil
                    let imageUrlAddr    = (storyData["image"]    as? String?) ?? nil
                    
                    let timeToRead: Int = Int(arc4random_uniform(19) + 1)
                    let createDate: Date = Date(detailString: createAt)
                    guard let readingType = ReadingType(rawValue: readingTypeTemp) else { return nil }
                    if readingType == .none {
                        return nil
                    }
                    
                    let story = ReadingListStory(storyId: storyId, userId: userId, name: name, title: title, subTitle: subTitle ?? text, publicationId: publicationId, publications: publications, readingListId: readingListId, readingType: readingType, createAt: createDate, imageUrlAddr: imageUrlAddr, timeToRead: timeToRead)
                    
                    stories.append(story)
                }
                return stories
            }
        }
        return nil
    }
    
    func jsonToRecentlyStories(_ json: Any?) -> [ReadingListStory]? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? [[String : Any]] {
                var stories: [ReadingListStory] = []
                for storyData in result {
                    guard let storyId   = storyData["storyId"]   as? Int     else { return nil }
                    guard let userId    = storyData["userId"]    as? Int     else { return nil }
                    guard let name      = storyData["name"]      as? String  else { return nil }
                    guard let title     = storyData["title"]     as? String  else { return nil }
                    let subTitle        = (storyData["subTitle"] as? String?) ?? nil
                    let readingListId   = (storyData["readingListId"] as? Int?) ?? nil
                    let readingTypeTemp = (storyData["readingType"] as? String) ?? "none"
                    let publicationId   = (storyData["publicationId"] as? Int?) ?? nil
                    let publications     = (storyData["publications"] as? String?) ?? nil
                    guard let createAt  = storyData["createAt"] as? String else { return nil }
                    let text            = (storyData["text"]     as? String?) ?? nil
                    let imageUrlAddr    = (storyData["image"]    as? String?) ?? nil
                    
                    let timeToRead: Int = Int(arc4random_uniform(19) + 1)
                    let createDate: Date = Date(detailString: createAt)
                    guard let readingType = ReadingType(rawValue: readingTypeTemp) else { return nil}
                    
                    let story = ReadingListStory(storyId: storyId, userId: userId, name: name, title: title, subTitle: subTitle ?? text, publicationId: publicationId, publications: publications, readingListId: readingListId, readingType: readingType, createAt: createDate, imageUrlAddr: imageUrlAddr, timeToRead: timeToRead, isRecently: true)
                    
                    stories.append(story)
                }
                return stories
            }
        }
        return nil
    }
}
