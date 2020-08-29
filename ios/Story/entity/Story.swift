//
//  Story.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

struct Story {
    
    let storyId: Int
    var readingListId: Int?
    var topic: String?
    var title: String
    var subtitle: String?
    var author: String
    var publication: String?
    var timeToRead: Int
    var storyImageUrlAddr: String?
    var authorImageUrlAddr: String?
    var createdDate: Date
    var numOfClaps: Int
    var isSaved: Bool
    
    var contents: [Contents] = []
        
    init(storyId: Int,
         readingListId: Int? = nil,
         topic: String? = nil,
         title: String,
         subtitle: String? = nil,
         author: String,
         publication: String?,
         timeToRead: Int,
         storyImageUrlAddr: String? = nil,
         authorImageUrlAddr: String? = nil,
         createdDate: Date,
         numOfClaps: Int,
         isSaved: Bool) {
        self.storyId = storyId
        self.readingListId = readingListId
        self.topic = topic
        self.title = title
        self.subtitle = subtitle
        self.author = author
        self.publication = publication
        self.timeToRead = timeToRead
        self.storyImageUrlAddr = storyImageUrlAddr
        self.authorImageUrlAddr = authorImageUrlAddr
        self.createdDate = createdDate
        self.numOfClaps = numOfClaps
        self.isSaved = isSaved
    }
    
    mutating func append(_ contents: Contents) {
        self.contents.append(contents)
    }
    
    mutating func appends(_ contents: [Contents]) {
        self.contents += contents
    }
}

extension Story {
    
    static func getDummy() -> Story {
        var story = Story(
            storyId: 6,
            topic: "Machine Learning",
            title: "Machine Learning is Fun!",
            subtitle: "The world's easiest introduction to Machine Learning",
            author: "Adam Geitgey",
            publication: nil,
            timeToRead: 15,
            storyImageUrlAddr: "https://miro.medium.com/max/3864/1*uorFgyflbSMtvfSo9hlI1A.png",
            authorImageUrlAddr: "https://miro.medium.com/fit/c/256/256/0*qaGRl18oAZnJiPjb.jpeg",
            createdDate: Date(year: 2014, month: 5, day: 6),
            numOfClaps: 123,
            isSaved: true)
        story.appends(Contents.getDummy())
        return story
    }
}
