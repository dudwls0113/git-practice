//
//  CreateBeginViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Firebase

class CreateBeginViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.topItem?.title = "Create"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "CreateBeginCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: CreateBeginCell.cellReuseIdentifier)

    }
}

extension CreateBeginViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateBeginCell.cellReuseIdentifier) as? CreateBeginCell else {
            return UITableViewCell()
        }
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let title = "Write a story"
            let contents = "Medium Stories are the easiest way to share your ideas with the world."
            cell.updateUI(title: title, contents: contents)
            return cell
        case (1, 0):
            let title = "Create a series"
            let contents = "Medium Series are mobile stories that can be added to over time and unfold card by card with the tap of a finger."
            cell.updateUI(title: title, contents: contents)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section + indexPath.row == 0 {
            if Auth.auth().currentUser == nil {
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
            } else {
                let createView = CreateWireframe.createCreateModule()
                createView.modalPresentationStyle = .fullScreen
                present(createView, animated: true, completion: nil)
            }
        }
    }
}
