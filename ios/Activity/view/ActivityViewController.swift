//
//  ActivityViewController.swift
//  Medium
//
//  Created by 윤영일 on 07/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class ActivityViewController: BaseViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Activity"
    }
}
