//
//  UIImage.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

extension UIImage {
//    convenience init?(urlAddr: String) {
//        if urlAddr.contains("firebase") {
//            self.init(named: "medium")
//        } else {
//            do {
//                let url: URL = URL(string: urlAddr)!
//                let data: Data = try Data(contentsOf: url)
//                self.init(data: data)!
//            } catch {
//                self.init()
//            }
//        }
//    }
    
    static let placeholder = UIImage(named: "placeholder")!
}
