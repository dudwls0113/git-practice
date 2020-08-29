//
//  MainInteractor.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Alamofire

class MainInteractor: MainInteractorInputProtocol {
    var presenter: MainInteractorOutputProtocol?
    
    func retrieveDailyReadStories() {
        var url: String = "\(AppDelegate.baseUrl)/popularlist"
        url += "?" + "pageNum=1"
        url += "&" + "pageCnt=5"
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let stories = self.jsonToDailyReadStory(response.result.value) {
                        self.presenter?.didRetrieveDailyReadStories(stories)
                    } else {
                        self.presenter?.didRetrieveDailyReadStories(DailyReadStory.getDummy())
                    }
                case .failure:
                    self.presenter?.didRetrieveDailyReadStories(DailyReadStory.getDummy())
                }
        }
    }
    
    func retrieveRecommendationStories(pageNum: Int, pageCnt: Int) {
        var url: String = "\(AppDelegate.baseUrl)/story"
        url += "?" + "pageNum=\(pageNum)"
        url += "&" + "pageCnt=\(pageCnt)"
        Alamofire
            .request(url, method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let stories = self.jsonToRecommendationStory(response.result.value) {
                        self.presenter?.didRetrieveRecommendationStories(stories)
                    } else {
                        self.presenter?.didRetrieveRecommendationStories(RecommendationStory.getDummy())
                    }
                case .failure:
                    self.presenter?.didRetrieveRecommendationStories(RecommendationStory.getDummy())
                }
        }
    }
    
    func jsonToDailyReadStory(_ json: Any?) -> [DailyReadStory]? {
        if let data = json as? Dictionary<String, Any> {
            if let result = data["result"] as? [Dictionary<String, Any>] {
                var stories: [DailyReadStory] = []
                for storyData in result {
                    guard let storyId   = storyData["storyId"]  as? Int     else { return nil }
                    let readingListId   = (storyData["readingListId"] as? Int?) ?? nil
                    guard let name      = storyData["name"]     as? String  else { return nil }
                    guard let title     = storyData["title"]    as? String  else { return nil }
                    let readingType     = (storyData["readingType"] as? String?) ?? nil
                    let text            = (storyData["text"]    as? String?) ?? nil
                    let imageUrlAddr    = (storyData["image"]   as? String?) ?? nil
                    
                    let isRead = (readingType != nil && readingType! == "arcive")
                    let isSaved = (readingType != nil && readingType! == "save")
                    let timeToRead: Int = (text != nil) ? (text!.count % 100) + 1 : Int(arc4random_uniform(19) + 1)
                    
                    let story = DailyReadStory(id: storyId, readingListId: readingListId, title: title, author: name, timeToRead: timeToRead, storyImageUrlAddr: imageUrlAddr, isRead: isRead, isSaved: isSaved)
                    stories.append(story)
                }
                return stories
            }
        }
        return nil
    }
    
    func jsonToRecommendationStory(_ json: Any?) -> [RecommendationStory]? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? [[String : Any]] {
                var stories: [RecommendationStory] = []
                for storyData in result {
                    guard let storyId   = storyData["storyId"]   as? Int     else { return nil }
                    guard let name      = storyData["name"]      as? String  else { return nil }
                    guard let title     = storyData["title"]     as? String  else { return nil }
                    let subTitle        = (storyData["subTitle"] as? String?) ?? nil
                    let readingListId   = (storyData["readingListId"] as? Int?) ?? nil
                    let topics          = (storyData["topics"]   as? String?) ?? nil
                    let publication     = (storyData["publication"] as? String?) ?? nil
                    let readingType     = (storyData["readingType"] as? String?) ?? nil
                    guard let createAt  = storyData["createAt"] as? String else { return nil }
                    let text            = (storyData["text"]     as? String?) ?? nil
                    let imageUrlAddr    = (storyData["image"]    as? String?) ?? nil
                    
                    let isSaved = (readingType != nil && readingType! == "save")
                    let timeToRead: Int = (text != nil) ? (text!.count % 100) + 1 : Int(arc4random_uniform(19) + 1)
                    let createDate: Date = Date(detailString: createAt)
                    
                    let story = RecommendationStory(storyId: storyId, readingListId: readingListId, title: title, topic: topics, contents: subTitle ?? text, author: name, publication: publication, timeToRead: timeToRead, storyImageUrlAddr: imageUrlAddr, isSaved: isSaved, createdDate: createDate)
                    
                    stories.append(story)
                }
                return stories
            }
        }
        return nil
    }
}
