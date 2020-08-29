//
//  ReadingListPainViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/14.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ReadingListPainViewController: BaseViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "ReadingList"
    }
}
