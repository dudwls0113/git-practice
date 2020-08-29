//
//  ReadingListViewController.swift
//  Medium
//
//  Created by 윤영일 on 07/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import SnapKit

class ReadingListViewController: BaseViewController {
    
    var swipeMenuView: SwipeMenuView!
//    var viewControllers: [(title: String, viewController: UIViewController?)] =
//        [("Saved", ReadingListWireframe.createReadingListSavedModule()),
//         ("Archived", nil),
//         ("Recently viewed", nil),
//         ("Highlighted", nil)]
    
    override func viewDidLoad() {
        showIndicator()
        
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Reading list"
        
        swipeMenuView = SwipeMenuView(frame: view.frame)
        
        swipeMenuView.delegate = self
        swipeMenuView.dataSource = self
        
        view.addSubview(swipeMenuView)
        
        swipeMenuView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.itemView.margin = 10.0
        options.tabView.itemView.font = UIFont(name: "Helvetica", size: 13.5)!
        options.tabView.itemView.textColor = .gray
        options.tabView.additionView.padding = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        swipeMenuView.reloadData(options: options)
    }
}

extension ReadingListViewController: SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        switch index {
        case 0: return ReadingListWireframe.createReadingListSavedModule(from: self)
        case 1: return ReadingListWireframe.createReadingListArchiveModule(from: self)
        case 2: return ReadingListWireframe.createReadingListRecentlyModule(from: self)
        default: return BaseViewController()
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        switch index {
        case 0: return "Saved"
        case 1: return "Archived"
        case 2: return "Recently viewded"
//        case 3: return "Highlighted"
        default: return ""
        }
    }
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
//        return 4
        return 3
    }
}
