//
//  DailyReadStory.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

struct DailyReadStory {
    
    let id: Int
    var readingListId: Int?
    var title: String
    var author: String
    var timeToRead: Int
    var storyImageUrlAddr: String?
    var publicationImageUrlAddr: String?
    var isRead: Bool
    var isSaved: Bool
    
    init(id: Int,
         readingListId: Int? = nil,
         title: String,
         author: String,
         timeToRead: Int,
         storyImageUrlAddr: String? = nil,
         publicationImageUrlAddr: String? = nil,
         isRead: Bool,
         isSaved: Bool = false)
    {
        self.id = id
        self.readingListId = readingListId
        self.title = title
        self.author = author
        self.timeToRead = timeToRead
        self.storyImageUrlAddr = storyImageUrlAddr
        self.publicationImageUrlAddr = publicationImageUrlAddr
        self.isRead = isRead
        self.isSaved = isSaved
    }
}

extension DailyReadStory {
    static func getDummy() -> [DailyReadStory] {
        var stories: [DailyReadStory] = []
        
        let story1 = DailyReadStory(id: 1,
                                    title: "How to Stop Overthinking",
                                    author: "Monk BeobJeong",
                                    timeToRead: 2,
                                    isRead: true)
        stories.append(story1)
        
        let story2 = DailyReadStory(id: 2,
                                    title: "30 Things I Wish I Knew When I Started Programming",
                                    author: "Programmer",
                                    timeToRead: 9,
                                    isRead: true)
        stories.append(story2)
        
        let story3 = DailyReadStory(id: 3,
                                    title: "An FBI Behaviour Expert Explains How to Quickly Build Trust With Anyone",
                                    author: "Thomas Oppong",
                                    timeToRead: 4,
                                    storyImageUrlAddr:  "https://miro.medium.com/max/2676/1*5KBaIxKrdKQlp3ZlmHxheQ.png",
                                    publicationImageUrlAddr:  "https://miro.medium.com/fit/c/160/160/1*M1G7XIOUgEfa2SPuOyLYIg.jpeg",
                                    isRead: false)
        stories.append(story3)
        
        let story4 = DailyReadStory(id: 4,
                                    title: "Why Women Lose Interest ― It's Two Things",
                                    author: "MaryBeth Gronek",
                                    timeToRead: 6,
                                    storyImageUrlAddr:  "https://miro.medium.com/max/10466/0*IzKOEdpJLFx3cF9a",
                                    isRead: false)
        stories.append(story4)
        
        let story5 = DailyReadStory(id: 5,
                                    title: "The Diffences Between a Junior, Mid-Level, and Senior Developer",
                                    author: "Daan",
                                    timeToRead: 6,
                                    isRead: false)
        stories.append(story5)
        return stories
    }

}
