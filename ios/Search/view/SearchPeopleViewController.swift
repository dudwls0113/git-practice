//
//  SearchPeopleViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/15.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SearchPeopleViewController: BaseViewController {
        
    var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        
        tableView = UITableView(frame: view.frame, style: .grouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNewUsers), name: SearchViewController.searchNewPeopleNotification, object: nil)
        
        let profileCell = UINib(nibName: "ProfileCell", bundle: nil)
        tableView.register(profileCell, forCellReuseIdentifier: ProfileCell.cellReuseIdentifier)
    }
    
    @objc func setNewUsers(_ notification: Notification) {
        if let users = notification.userInfo?["users"] as? [User] {
            self.users = users
            tableView.reloadData()
        }
    }
}

extension SearchPeopleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellReuseIdentifier) as? ProfileCell {
            cell.updateUI(name: users[indexPath.row].name, imageUrlAddr: users[indexPath.row].imageUrlAddr)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileView = ProfileViewController()
        present(profileView, animated: true) {
            profileView.setUserInfo(self.users[indexPath.row].userId)
        }
    }
}
