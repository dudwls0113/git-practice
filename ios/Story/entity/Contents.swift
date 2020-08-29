//
//  Contents.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

enum ContentsType: String {
    case LargeText, SmallText, Quote, Separator, Image
}

class Contents {
    var type: ContentsType
    var contents: String?
    var isHighlighted: Bool
    
    init(type: ContentsType, contents: String? = nil, isHighlighted: Bool = false) {
        self.type = type
        self.contents = contents
        self.isHighlighted = isHighlighted
    }
}

extension Contents {
    static func getDummy() -> [Contents] {
        var contents: [Contents] = []
        contents.append(Contents(type: .Image, contents: "https://miro.medium.com/max/3864/1*uorFgyflbSMtvfSo9hlI1A.png"))
        contents.append(Contents(type: .SmallText, contents: "Have you heard people talking about machine learning but only have a fuzzy idea of what that means? Are you tired of nodding your way through conversations with co-workers? Let’s change that!"))
        contents.append(Contents(type: .Separator))
        contents.append(Contents(type: .SmallText, contents: "This guide is for anyone who is curious about machine learning but has no idea where to start. I imagine there are a lot of people who tried reading the wikipedia article, got frustrated and gave up wishing someone would just give them a high-level explanation. That’s what this is."))
        contents.append(Contents(type: .SmallText, contents: "The goal is be accessible to anyone — which means that there’s a lot of generalizations. But who cares? If this gets anyone more interested in ML, then mission accomplished."))
        contents.append(Contents(type: .Separator))
        contents.append(Contents(type: .LargeText, contents: "What is machine learning?"))
        contents.append(Contents(type: .Quote, contents: "Machine Learning is so EASY!!", isHighlighted: false))
        contents.append(Contents(type: .Quote, contents: "NO!!! It's So hard!!\n-Zero", isHighlighted: true))
        contents.append(Contents(type: .SmallText, contents: "Machine learning is the idea that there are generic algorithms that can tell you something interesting about a set of data without you having to write any custom code specific to the problem. Instead of writing code, you feed data to the generic algorithm and it builds its own logic based on the data.", isHighlighted: true))
        contents.append(Contents(type: .SmallText, contents: "For example, one kind of algorithm is a classification algorithm. It can put data into different groups. The same classification algorithm used to recognize handwritten numbers could also be used to classify emails into spam and not-spam without changing a line of code. It’s the same algorithm but it’s fed different training data so it comes up with different classification logic."))
        contents.append(Contents(type: .Image, contents: "https://miro.medium.com/max/2020/1*YXiclXZdJQVJZ0tQHCv5zw.png"))
        contents.append(Contents(type: .SmallText, contents: "“Machine learning” is an umbrella term covering lots of these kinds of generic algorithms."))
        return contents
    }
}
