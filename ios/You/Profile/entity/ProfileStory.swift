//
//  ProfileStory.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ProfileStory {
    let id: Int
    var readingListId: Int?
    var title: String
    var contents: String?
    var author: String
    var publication: String?
    var timeToRead: Int
    var storyImageUrlAddr: String?
    var authorImageUrlAddr: String?
    var createdDate: Date
    var readingType: ReadingType
    
    init(id: Int, readingListId: Int? = nil, title: String, contents: String?, author: String, publication: String? = nil, timeToRead: Int, storyImageUrlAddr: String? = nil, authorImageUrlAddr: String? = nil, createdDate: Date, readingType: ReadingType = .none) {
        self.id = id
        self.readingListId = readingListId
        self.title = title
        self.contents = contents
        self.author = author
        self.publication = publication
        self.timeToRead = timeToRead
        self.storyImageUrlAddr = storyImageUrlAddr
        self.authorImageUrlAddr = authorImageUrlAddr
        self.createdDate = createdDate
        self.readingType = readingType
    }
}

extension ProfileStory {
    static func getDummy() -> [ProfileStory] {
        var stories: [ProfileStory] = []
        
        let story1 = ProfileStory(
            id: 6,
            title: "The Decline and Fall of the Modern Nerd",
            contents: "The sad saga of how fandom transformed from being about love into hate and intolerance",
            author: "Rob Bricken",
            publication: "OneZero",
            timeToRead: 8,
            storyImageUrlAddr: "https://miro.medium.com/max/3004/0*Eqk9b_FxwQ_qoV4l.jpg",
            authorImageUrlAddr: "https://cdn-images-1.medium.com/max/810/1*zv9JXqaS9O8OcHTzOoGPUA@2x.png",
            createdDate: Date(year: 2019, month: 9, day: 14),
            readingType: .save)
        stories.append(story1)
        
        let story2 = ProfileStory(
            id: 6,
            title: "Why should you learn Go?",
            contents: "\"Go will be the server language of the future.\" — Tobias Lütke, Shopify Keval Patel",
            author: "Keval Patel",
            publication: nil,
            timeToRead: 8,
            storyImageUrlAddr: "https://miro.medium.com/max/1000/1*vHUiXvBE0p0fLRwFHZuAYw.gif",
            createdDate: Date(year: 2017, month: 1, day: 8),
            readingType: .none)
        stories.append(story2)
        
        let story3 = ProfileStory(
            id: 7,
            title: "Step by Step: RecyclerView Swipe to Delete and Undo",
            contents: "Swipe to delete is a prevailing paradigm users are accustomed to on mobile platforms. Adding this functionally is a good way to get your what?",
            author: "Zachery Osborn",
            publication: nil,
            timeToRead: 4,
            storyImageUrlAddr: "https://miro.medium.com/max/3800/1*MFp4VmDb0OTebB-6I5VSOw.jpeg",
            createdDate: Date(year: 2018, month: 9, day: 12),
            readingType: .archive)
        stories.append(story3)
        
        let story4 = ProfileStory(
            id: 8,
            title: "The Problem With Autonomous Cars That No One’s Talking About",
            contents: "Autonomous cars need to learn how to drive like a local",
            author: "Fast Company",
            publication: nil,
            timeToRead: 10,
            createdDate: Date(year: 2019, month: 8, day: 21),
            readingType: .archive)
        stories.append(story4)
        
        let story5 = ProfileStory(
            id: 9,
            title: "Why our team cancelled our move to microservices",
            contents: "Recently our development team had a small break in our feature delivery schedule. Technical leadership decided that this time would be good!",
            author: "Steven Lemon",
            publication: nil,
            timeToRead: 8,
            createdDate: Date(year: 2019, month: 8, day: 10),
            readingType: .save)
        stories.append(story5)
        
        return stories
    }
}
