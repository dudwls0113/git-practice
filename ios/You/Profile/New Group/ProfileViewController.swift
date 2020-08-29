//
//  ProfileViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwipeMenuViewController
import Kingfisher

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var followingLab: UILabel!
    @IBOutlet weak var followersLab: UILabel!
    
    @IBOutlet weak var swipeMenuView: SwipeMenuView!
    
    var userId: Int = 7
    
    override func viewDidLoad() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .darkGray
        
        profileView.layer.borderWidth = 0.3
        profileView.layer.borderColor = UIColor.lightGray.cgColor
        
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.image = UIImage(systemName: "person.crop.circle.fill")
        nameLab.text = "Unknown"
        followingLab.text = "0"
        followersLab.text = "0"
        
        getUserInfo()
        
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.itemView.margin = 10.0
        options.tabView.itemView.font = UIFont(name: "Helvetica", size: 13.5)!
        options.tabView.itemView.textColor = .gray
        options.tabView.additionView.padding = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        swipeMenuView.reloadData(options: options)
    }
    
    func setUserInfo(_ userId: Int) {
        self.userId = userId
        getUserInfo()
    }
    
    func getUserInfo() {
        Alamofire
            .request("\(AppDelegate.baseUrl)/user/\(7)", method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let result = data["result"] as? Dictionary<String, Any> {
                            if let name = result["name"] as? String {
                                self.nameLab.text = name
                            }
                            if let image = result["image"] as? String {
                                self.profileImg.kf.setImage(with: URL(string: image.trimmingCharacters(in: [" ", "\n", "\r"])), placeholder: UIImage(systemName: "person.crop.circle.fill"))
                            }
                            if let followersCnt = result["followersCnt"] as? Int {
                                self.followersLab.text = "\(followersCnt)"
                            }
                            if let followingCnt = result["followingCnt"] as? Int {
                                self.followingLab.text = "\(followingCnt)"
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

extension ProfileViewController: SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return 4
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        switch index {
        case 0:  return "Profile"
        case 1:  return "Latest"
        case 2:  return "Claps"
        case 3:  return "Highlights"
        default: return ""
        }
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return LatestViewController()
    }
}
