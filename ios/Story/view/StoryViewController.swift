//
//  StoryViewController.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Firebase

class StoryViewController: BaseViewController {
    
    var presenter: StoryPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    var tabBar: UITabBar!
    var clapBtn: UITabBarItem!
    var actionBtn: UITabBarItem!
    var saveBtn: UITabBarItem!
    var sizeBtn: UITabBarItem!
    
    var viewControllers: [UIViewController] = []
    var story: Story!
    
    let thumbsupImage = UIImage(systemName: "hand.thumbsup")//?.withBaselineOffset(fromBottom: 10)
    let thumbsupFillImage = UIImage(systemName: "hand.thumbsup.fill")//?.withBaselineOffset(fromBottom: 10)
    let actionImage = UIImage(systemName: "square.and.arrow.up")//?.withBaselineOffset(fromBottom: 10)
    let bookmarkImage = UIImage(systemName: "bookmark")//?.withBaselineOffset(fromBottom: 5)
    let bookmarkFillImage = UIImage(systemName: "bookmark.fill")//?.withBaselineOffset(fromBottom: 5)
    let sizeImage = UIImage(systemName: "textformat.size")//?.withBaselineOffset(fromBottom: 10)
    
    var clapBtnChangeCnt: Int = 0
    var saveBtnChangeCnt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Medium"
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//        clapBtn = UITabBarItem(title: nil, image: thumbsupImage, selectedImage: thumbsupImage)
//        actionBtn = UITabBarItem(title: nil, image: actionImage, selectedImage: actionImage)
//        saveBtn = UITabBarItem(title: nil, image: bookmarkImage, selectedImage: bookmarkImage)
//        sizeBtn = UITabBarItem(title: nil, image: sizeImage, selectedImage: sizeImage)
//
//        clapBtn.badgeColor = .moss
//        actionBtn.badgeColor = .moss
//        saveBtn.badgeColor = .moss
//        sizeBtn.badgeColor = .moss
//
//        tabBar = UITabBar()
//        tabBar.delegate = self
//        tabBar.tintColor = .darkGray
//        tabBar.unselectedItemTintColor = .darkGray
//        tabBar.tintColorDidChange()
//        tabBar.isTranslucent = false
//        tabBar.items = [clapBtn, actionBtn, saveBtn, sizeBtn]
//
//        view.addSubview(tabBar)
//
//        tabBar.snp.makeConstraints { make in
//            make.leading.leading.equalTo(0)
//            make.trailing.trailing.equalTo(0)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//            make.height.equalTo(50)
//        }
//
        tableView.delegate = self
        tableView.dataSource = self
//        tabBar.delegate = self
        
        let titleCell = UINib(nibName: "StoryTitleCell", bundle: nil)
        let largeTextCell = UINib(nibName: "StoryLargeTextCell", bundle: nil)
        let smallTextCell = UINib(nibName: "StorySmallTextCell", bundle: nil)
        let quoteTextCell = UINib(nibName: "StoryQuoteCell", bundle: nil)
        let separatorCell = UINib(nibName: "StorySeparatorCell", bundle: nil)
        let imageCell = UINib(nibName: "StoryImageCell", bundle: nil)
        
        tableView.register(titleCell, forCellReuseIdentifier: StoryTitleCell.cellReuseIdentifier)
        tableView.register(largeTextCell, forCellReuseIdentifier: StoryLargeTextCell.cellReuseIdentifier)
        tableView.register(smallTextCell, forCellReuseIdentifier: StorySmallTextCell.cellReuseIdentifier)
        tableView.register(quoteTextCell, forCellReuseIdentifier: StoryQuoteCell.cellReuseIdentifier)
        tableView.register(separatorCell, forCellReuseIdentifier: StorySeparatorCell.cellReuseIdentifier)
        tableView.register(imageCell, forCellReuseIdentifier: StoryImageCell.cellReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isTranslucent = false
    }
}

extension StoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 + story.contents.count + 1
        case 1:
            return 0
        case 2:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        // Title
        case (0, 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTitleCell.cellReuseIdentifier) as? StoryTitleCell else {
                return UITableViewCell()
            }
            cell.updateUI(story)
            return cell
        // Story
        case (0, let i) where i < story.contents.count + 1:
            let contents = story.contents[i - 1]
            switch contents.type {
            case .LargeText:
                if let cell = tableView.dequeueReusableCell(withIdentifier: StoryLargeTextCell.cellReuseIdentifier) as? StoryLargeTextCell {
                    if let text = contents.contents {
                        cell.updateUI(text)
                        return cell
                    }
                }
                return UITableViewCell()
            case .SmallText:
                if let cell = tableView.dequeueReusableCell(withIdentifier: StorySmallTextCell.cellReuseIdentifier) as? StorySmallTextCell {
                    if let text = contents.contents {
                        cell.updateUI(text, contents.isHighlighted)
                        return cell
                    }
                }
                return UITableViewCell()
            case .Quote:
                if let cell = tableView.dequeueReusableCell(withIdentifier: StoryQuoteCell.cellReuseIdentifier) as? StoryQuoteCell {
                    if let text = contents.contents {
                        cell.updateUI(text, contents.isHighlighted)
                        return cell
                    }
                }
                return UITableViewCell()
            case .Separator:
                if let cell = tableView.dequeueReusableCell(withIdentifier: StorySeparatorCell.cellReuseIdentifier) as? StorySeparatorCell {
                    return cell
                }
                return UITableViewCell()
            case .Image:
                if let cell = tableView.dequeueReusableCell(withIdentifier: StoryImageCell.cellReuseIdentifier) as? StoryImageCell {
                    if let urlAddr = contents.contents {
                        cell.updateUI(imageUrlAddr: urlAddr, width: view.frame.width)
                        return cell
                    }
                }
                return UITableViewCell()
            }
        case (0, _):
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 {
            return nil
        }
        
        let contents = story.contents[indexPath.row - 1]
        if contents.type == .Separator || contents.type == .Image {
            return nil
        }
                
        let action = UIContextualAction(style: .normal, title: contents.isHighlighted ? "Unhighlight" : "Highlight") { action, view, success in
            if contents.isHighlighted {
                self.presenter?.unhighlightStory(storyId: self.story.storyId, contentsId: indexPath.row - 1)
            } else {
                self.presenter?.highlightStory(storyId: self.story.storyId, contentsId: indexPath.row - 1)
            }
        }
        action.backgroundColor = .moss
        action.image = UIImage(systemName: contents.isHighlighted ? "paintbrush.fill" : "paintbrush")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension StoryViewController: StoryViewProrotol {

    func setStory(_ story: Story) {
        self.story = story
        if let publication = story.publication {
            navigationItem.title = publication
        }
        
        clapBtn = UITabBarItem(title: nil, image: thumbsupImage, selectedImage: thumbsupImage)
        actionBtn = UITabBarItem(title: nil, image: actionImage, selectedImage: actionImage)
        saveBtn = UITabBarItem(title: nil, image: (story.isSaved) ? bookmarkFillImage : bookmarkImage, selectedImage: (story.isSaved) ? bookmarkFillImage : bookmarkImage)
        sizeBtn = UITabBarItem(title: nil, image: sizeImage, selectedImage: sizeImage)
        
        clapBtn.badgeValue = (story.numOfClaps > 0) ? "\(story.numOfClaps)" : nil
        clapBtn.badgeColor = .moss
        actionBtn.badgeColor = .moss
        saveBtn.badgeColor = .moss
        sizeBtn.badgeColor = .moss
        
        if Auth.auth().currentUser == nil {
            clapBtn.isEnabled = false
            saveBtn.isEnabled = false
        }
        
        tabBar = UITabBar()
        tabBar.delegate = self
        tabBar.tintColor = .darkGray
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColorDidChange()
        tabBar.isTranslucent = false
        tabBar.items = [clapBtn, actionBtn, saveBtn, sizeBtn]
        
        view.addSubview(tabBar)
        
        tabBar.snp.makeConstraints { make in
            make.leading.leading.equalTo(0)
            make.trailing.trailing.equalTo(0)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        
        tabBar.delegate = self
    }
    
    func setStoryHighlight(_ contentsId: Int) {
        story.contents[contentsId].isHighlighted = true
        tableView.reloadRows(at: [IndexPath(row: contentsId + 1, section: 0)], with: .none)
    }
    
    func setStoryUnhighlight(_ contentsId: Int) {
        story.contents[contentsId].isHighlighted = false
        tableView.reloadRows(at: [IndexPath(row: contentsId + 1, section: 0)], with: .none)
    }
    
    func setClap() {
        story.numOfClaps += 1
        clapBtnChangeCnt += 1
        self.clapBtn.image = self.thumbsupFillImage
        self.clapBtn.selectedImage = self.thumbsupFillImage
        self.clapBtn.badgeValue = "\(self.story.numOfClaps)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.clapBtnChangeCnt <= 1 {
                self.clapBtn.image = self.thumbsupImage
                self.clapBtn.selectedImage = self.thumbsupImage
            }
        }
        clapBtnChangeCnt -= 1
    }
    
    func setSaved(_ readingListId: Int) {
        story.readingListId = readingListId
        story.isSaved = true
        saveBtnChangeCnt += 1
        self.saveBtn.image = self.bookmarkFillImage
        self.saveBtn.selectedImage = self.bookmarkFillImage
        self.saveBtn.badgeValue = "saved"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.saveBtnChangeCnt <= 1 {
                self.saveBtn.badgeValue = nil
            }
        }
        saveBtnChangeCnt -= 1
    }
    
    func setUnsaved() {
        story.readingListId = nil
        story.isSaved = false
        saveBtnChangeCnt += 1
        
        self.saveBtn.image = self.bookmarkImage
        self.saveBtn.selectedImage = self.bookmarkImage
        self.saveBtn.badgeValue = "unsaved"

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.saveBtnChangeCnt <= 1 {
                self.saveBtn.badgeValue = nil
            }
        }
        saveBtnChangeCnt -= 1
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension StoryViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case clapBtn:
            presenter?.clapStory(story.storyId)
            break
        case saveBtn where story.isSaved:
            if let readingListId = story.readingListId {
                presenter?.unsaveStory(readingListId)
            } else {
                showAlert("Failed to unsave story.")
            }
            break
        case saveBtn:
            presenter?.saveStory(story.storyId)
            break
        default:
            break
        }
    }
}
