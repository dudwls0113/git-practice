//
//  StoryInteractor.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import Alamofire

class StoryInteractor: StoryInteractorInputProtocol {
    var presenter: StoryInteractorOutputProtocol?
    
    func requestStory(_ storyId: Int) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/story/\(storyId)", method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.presenter?.didRetrieveStory(self.jsonToStory(response.result.value))
                case .failure:
                    self.presenter?.didRetrieveStory(nil)
                }
        }
    }
    
    func requestHighlightStory(storyId: Int, contentsId: Int) {
        presenter?.didHighlightStory(contentsId)
    }
    
    func requestUnhighlightStory(storyId: Int, contentsId: Int) {
        presenter?.didUnhighlightStory(contentsId)
    }
    
    func requestClapStory(_ storyId: Int) {
        Alamofire
            .request("\(AppDelegate.baseUrl)/story/\(storyId)/clap", method: .post, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let isSuccess = data["isSuccess"] as? Bool {
                            self.presenter?.didClapStory(isSuccess)
                            break
                        }
                    }
                    self.presenter?.didClapStory(false)
                case .failure:
                    self.presenter?.didClapStory(false)
                }
        }
    }
        
    func jsonToStory(_ json: Any?) -> Story? {
        if let data = json as? [String : Any] {
            if let result = data["result"] as? Dictionary<String, Any> {
                guard let storyId   = result["storyId"]   as? Int     else { return nil }
                let readingListId   = (result["readingListId"] as? Int?) ?? nil
                guard let name      = result["name"]      as? String  else { return nil }
                guard let title     = result["title"]     as? String  else { return nil }
                let subTitle        = (result["subTitle"] as? String?) ?? nil
                let topics          = (result["topics"]   as? String?) ?? nil
                let publication     = (result["publication"] as? String?) ?? nil
                let readingType     = (result["readingType"] as? String?) ?? nil
                let clapCnt         = (result["clapCnt"]  as? Int) ?? 0
                guard let createAt  = result["createAt"]  as? String else { return nil }
                let text            = (result["text"]     as? String?) ?? nil
                let imageUrlAddr    = (result["image"]    as? String?) ?? nil

                let isSaved = (readingType != nil && readingType! == "save")
                let timeToRead: Int = (text != nil) ? (text!.count % 100) + 1 : 1
                let createDate: Date = Date(detailString: createAt)
                
                var story = Story(storyId: storyId, readingListId: readingListId, topic: topics, title: title, subtitle: subTitle, author: name, publication: publication, timeToRead: timeToRead, storyImageUrlAddr: imageUrlAddr, createdDate: createDate, numOfClaps: clapCnt, isSaved: isSaved)
                
                guard let contentsListData = result["contentsList"] as? [[String:Any]] else { return nil }
                for contentsData in contentsListData {
                    guard let type = contentsData["type"] as? String else { return nil }
                    guard let cont = contentsData["contents"] as? String else { return nil }
                    
                    var contentsType: ContentsType!
                    switch type {
                    case "LargeText", "SmallText", "Quote", "Separator", "Image":
                            contentsType = ContentsType(rawValue: type)
                    case "text":
                        contentsType = .SmallText
                    case "image":
                        contentsType = .Image
                    default:
                        return nil
                    }
                    
                    let contents = Contents(type: contentsType, contents: cont)
                    story.append(contents)
                }
                
                return story
            }
        }
        return nil
    }
}
