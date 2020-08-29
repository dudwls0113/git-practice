//
//  YouViewController.swift
//  Medium
//
//  Created by 윤영일 on 07/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class YouViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let titles: [[String]] = [["Profile"],
                                      ["Become a member", "Restore purchase"],
                                      ["Stories", "Series", "Stats", "Customize your intersets"],
                                      ["Settings", "Help", "Terms of service", "Privacy policy"],
                                      ["Sign out"]]
    
    var name: String?
    var image: String?
    var userId: Int = 7
    
    override func viewDidLoad() {        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.transparent()

        tableView.delegate = self
        tableView.dataSource = self
        
        let profileCell = UINib(nibName: "ProfileCell", bundle: nil)
        tableView.register(profileCell, forCellReuseIdentifier: ProfileCell.cellReuseIdentifier)
        
        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "You"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setUserId(_ userId: Int) {
        self.userId = userId
        getUserInfo()
    }
    
    func getUserInfo() {
        Alamofire
            .request("\(AppDelegate.baseUrl)/user/\(userId)", method: .get, encoding: JSONEncoding.default, headers: AppDelegate.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.result.value as? [String : Any] {
                        if let result = data["result"] as? [String : Any] {
                            if let name = result["name"] as? String {
                                self.name = name
                            }
                            if let image = result["image"] as? String {
                                self.image = image.trimmingCharacters(in: [" ", "\n", "\r"])
                            }
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

extension YouViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 4: return 1
        case 1:    return 2
        case 2, 3: return 4
        default:   return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ? ProfileCell.height : 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basicCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        basicCell.textLabel?.text = titles[indexPath.section][indexPath.row]
        basicCell.textLabel?.font = basicCell.textLabel?.font.withSize(14)
        basicCell.selectionStyle = .none
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellReuseIdentifier) as? ProfileCell else {
                return UITableViewCell()
            }
            profileCell.updateUI(name: name ?? "Unkown", imageUrlAddr: image)
            return profileCell
        case (1, 0):
            basicCell.textLabel?.textColor = .moss
            return basicCell
        case (1, 1), (2, 0..<4), (3, 0..<4), (4, 0):
            return basicCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0) where Auth.auth().currentUser != nil:
            let profileView = ProfileViewController()
            navigationController?.pushViewController(profileView, animated: true)
            profileView.setUserInfo(userId)
            break
        case(0, 0):
            let alert = UIAlertController(title: "You have to login to create your story.", message: "Do you want to go sign up page?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: .default) { action in
                LoginInteractor.signOut(from: self)
            }
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            break
        case (4, 0):
            LoginInteractor.signOut(from: self)
            break
        default:
            break
        }
    }
}
