//
//  ReadingListStoryCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/12.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ReadingListStory {
    let storyId: Int
    var userId: Int
    var name: String
    var title: String
    var subTitle: String?
    var publicationId: Int?
    var publications: String?
    var readingListId: Int?
    var readingType: ReadingType
    var createAt: Date
    var imageUrlAddr: String?
    var timeToRead: Int
    var isRecently: Bool
    
    init(storyId: Int,
         userId: Int,
         name: String,
         title: String,
         subTitle: String? = nil,
         publicationId: Int? = nil,
         publications: String? = nil,
         readingListId: Int? = nil,
         readingType: ReadingType,
         createAt: Date,
         imageUrlAddr: String? = nil,
         timeToRead: Int,
         isRecently: Bool = false) {
        self.storyId = storyId
        self.userId = userId
        self.name = name
        self.title = title
        self.subTitle = subTitle
        self.publicationId = publicationId
        self.publications = publications
        self.readingListId = readingListId
        self.readingType = readingType
        self.createAt = createAt
        self.imageUrlAddr = imageUrlAddr
        self.timeToRead = timeToRead
        self.isRecently = isRecently
    }
}
