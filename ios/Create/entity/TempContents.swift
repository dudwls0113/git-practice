//
//  TempContents.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class TempContents {
    var type: ContentsType
    var contents: String?
    var image: UIImage?
    
    init(type: ContentsType, contents: String? = nil) {
        self.type = type
        self.contents = contents
    }
    
    init(image: UIImage) {
        self.type = .Image
        self.image = image
    }
}
