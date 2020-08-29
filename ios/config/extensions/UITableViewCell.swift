//
//  UITableViewCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 414)
    }
    
    func showSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
