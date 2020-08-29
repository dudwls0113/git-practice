//
//  RecommendationStory.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

struct RecommendationStory {
    
    let storyId: Int
    var readingListId: Int?
    var title: String
    var topic: String?
    var contents: String?
    var author: String
    var publication: String?
    var timeToRead: Int
    var storyImageUrlAddr: String?
    var publicationImageUrlAddr: String?
    var isSaved: Bool
    var createdDate: Date
    
    init(storyId: Int,
         readingListId: Int? = nil,
         title: String,
         topic: String? = nil,
         contents: String? = nil,
         author: String,
         publication: String? = nil,
         timeToRead: Int,
         storyImageUrlAddr: String? = nil,
         publicationImageUrlAddr: String? = nil,
         isSaved: Bool,
         createdDate: Date)
    {
        self.storyId = storyId
        self.readingListId = readingListId
        self.title = title
        self.topic = topic
        self.contents = contents
        self.author = author
        self.publication = publication
        self.timeToRead = timeToRead
        self.storyImageUrlAddr = storyImageUrlAddr
        self.publicationImageUrlAddr = publicationImageUrlAddr
        self.isSaved = isSaved
        self.createdDate = createdDate
    }
}

extension RecommendationStory {
    static func getDummy() -> [RecommendationStory] {
        var stories: [RecommendationStory] = []
        
        let story1 = RecommendationStory(
            storyId: 6,
            title: "The Decline and Fall of the Modern Nerd",
            topic: "FILM",
            contents: "The sad saga of how fandom transformed from being about love into hate and intolerance",
            author: "Rob Bricken",
            publication: "OneZero",
            timeToRead: 8,
            storyImageUrlAddr: "https://miro.medium.com/max/3004/0*Eqk9b_FxwQ_qoV4l.jpg",
            publicationImageUrlAddr: "https://cdn-images-1.medium.com/max/810/1*zv9JXqaS9O8OcHTzOoGPUA@2x.png",
            isSaved: true,
            createdDate: Date(year: 2019, month: 9, day: 14))
        stories.append(story1)
        
        let story2 = RecommendationStory(
            storyId: 6,
            title: "Why should you learn Go?",
            topic: "PROGRAMMING",
            contents: "\"Go will be the server language of the future.\" — Tobias Lütke, Shopify Keval Patel",
            author: "Keval Patel",
            publication: nil,
            timeToRead: 8,
            storyImageUrlAddr: "https://miro.medium.com/max/1000/1*vHUiXvBE0p0fLRwFHZuAYw.gif",
            isSaved: false,
            createdDate: Date(year: 2017, month: 1, day: 8))
        stories.append(story2)
        
        let story3 = RecommendationStory(
            storyId: 7,
            title: "Step by Step: RecyclerView Swipe to Delete and Undo",
            topic: nil,
            contents: "Swipe to delete is a prevailing paradigm users are accustomed to on mobile platforms. Adding this functionally is a good way to get your what?",
            author: "Zachery Osborn",
            publication: nil,
            timeToRead: 4,
            storyImageUrlAddr: "https://miro.medium.com/max/3800/1*MFp4VmDb0OTebB-6I5VSOw.jpeg",
            isSaved: false,
            createdDate: Date(year: 2018, month: 9, day: 12))
        stories.append(story3)
        
        let story4 = RecommendationStory(
            storyId: 8,
            title: "The Problem With Autonomous Cars That No One’s Talking About",
            topic: "AUTOMOBILE",
            contents: "Autonomous cars need to learn how to drive like a local",
            author: "Fast Company",
            publication: nil,
            timeToRead: 10,
            isSaved: true,
            createdDate: Date(year: 2019, month: 8, day: 21))
        stories.append(story4)
        
        let story5 = RecommendationStory(
            storyId: 9,
            title: "Why our team cancelled our move to microservices",
            topic: nil,
            contents: "Recently our development team had a small break in our feature delivery schedule. Technical leadership decided that this time would be good!",
            author: "Steven Lemon",
            publication: nil,
            timeToRead: 8,
            isSaved: false,
            createdDate: Date(year: 2019, month: 8, day: 10))
        stories.append(story5)
        
        return stories
    }
}
