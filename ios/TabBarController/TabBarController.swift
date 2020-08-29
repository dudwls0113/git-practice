//
//  TabBarController.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        tabBar.isTranslucent           = false
        tabBar.barTintColor            = .black
        tabBar.tintColor               = .white
        tabBar.unselectedItemTintColor = .darkGray

        let mainViewController: BaseViewController = MainWireframe.createMainModule()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.tabBarItem =
            UITabBarItem(title: nil,
                         image: UIImage(named: "tab_bar_btn_home")?.withBaselineOffset(fromBottom: 15),
                         selectedImage: UIImage(named: "tab_bar_btn_home_clicked")?.withBaselineOffset(fromBottom: 15))
        
        let readingListViewController: BaseViewController = Auth.auth().currentUser == nil ? ReadingListPainViewController() : ReadingListWireframe.createReadingListModule()
        let readingListNavigationController = UINavigationController(rootViewController: readingListViewController)
        readingListNavigationController.tabBarItem =
            UITabBarItem(title: nil,
                         image: UIImage(named: "tab_bar_btn_bookmark")?.withBaselineOffset(fromBottom: 15),
                         selectedImage: UIImage(named: "tab_bar_btn_bookmark_clicked")?.withBaselineOffset(fromBottom: 15))
        
        let createViewController: BaseViewController = CreateWireframe.createCreateBeginModule()
        let createNavigationController = UINavigationController(rootViewController: createViewController)
        createNavigationController.tabBarItem =
            UITabBarItem(title: nil,
                         image: UIImage(named: "tab_bar_btn_write")?.withBaselineOffset(fromBottom: 15),
                         selectedImage: UIImage(named: "tab_bar_btn_write_clicked")?.withBaselineOffset(fromBottom: 15))
        
        let activityViewController: BaseViewController = SearchViewController()
//        let activityViewController: BaseViewController = ActivityViewController()
        let activityNavigationController = UINavigationController(rootViewController: activityViewController)
        activityNavigationController.tabBarItem =
            UITabBarItem(title: nil,
                         image: UIImage(named: "tab_bar_btn_alarm")?.withBaselineOffset(fromBottom: 15),
                         selectedImage: UIImage(named: "tab_bar_btn_alarm_clicked")?.withBaselineOffset(fromBottom: 15))
        
        let youViewController: YouViewController = YouViewController()
        let youNavigationController = UINavigationController(rootViewController: youViewController)
        youNavigationController.tabBarItem =
            UITabBarItem(title: nil,
                         image: UIImage(named: "tab_bar_btn_profile")?.withBaselineOffset(fromBottom: 15),
                         selectedImage: UIImage(named: "tab_bar_btn_profile_clicked")?.withBaselineOffset(fromBottom: 15))
        
        viewControllers = [mainNavigationController, readingListNavigationController, createNavigationController, activityNavigationController, youNavigationController]
//        selectedIndex = 3
    }
}
