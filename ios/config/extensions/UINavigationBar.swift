//
//  UINavigationBar.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
