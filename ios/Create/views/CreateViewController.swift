//
//  CreateViewController.swift
//  Medium
//
//  Created by 윤영일 on 07/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Photos
import Firebase

class CreateViewController: BaseViewController {
    
    let imagePicker = UIImagePickerController()
    var presenter: CreatePresenterProtocol?
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var textBtn: UITabBarItem!
    @IBOutlet weak var quoteBtn: UITabBarItem!
    @IBOutlet weak var separatorBtn: UITabBarItem!
    @IBOutlet weak var imageBtn: UITabBarItem!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var storyTitle: String?
    var contents: [TempContents] = []
    
    var editIndex: Int = 0
    var editMode: ContentsType?
    
    let smallTextImage = UIImage(named: "small_text_btn")
    let largeTextImage = UIImage(named: "large_text_btn")
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Create"
        
        cancelBtn.action = #selector(pressedCancel)
        doneBtn.action = #selector(pressedDone)
        
        imagePicker.delegate = self
        tabBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let titleCell = UINib(nibName: "StoryTitleEditCell", bundle: nil)
        let largeTextCell = UINib(nibName: "StoryLargeTextEditCell", bundle: nil)
        let smallTextCell = UINib(nibName: "StorySmallTextEditCell", bundle: nil)
        let quoteCell = UINib(nibName: "StoryQuoteEditCell", bundle: nil)
        let separatorCell = UINib(nibName: "StorySeparatorCell", bundle: nil)
        let imageCell = UINib(nibName: "StoryImageCell", bundle: nil)
        
        tableView.register(titleCell, forCellReuseIdentifier: StoryTitleEditCell.cellReuseIdentifier)
        tableView.register(largeTextCell, forCellReuseIdentifier: StoryLargeTextEditCell.cellReuseIdentifier)
        tableView.register(smallTextCell, forCellReuseIdentifier: StorySmallTextEditCell.cellReuseIdentifier)
        tableView.register(quoteCell, forCellReuseIdentifier: StoryQuoteEditCell.cellReuseIdentifier)
        tableView.register(separatorCell, forCellReuseIdentifier: StorySeparatorCell.cellReuseIdentifier)
        tableView.register(imageCell, forCellReuseIdentifier: StoryImageCell.cellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(beginEditing(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(finishEditing(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func pressedCancel(_ sender: UIButton) {
        view.endEditing(true)
        let alert = UIAlertController(title: nil, message: "Your work will disappear.\nDo you really want to go out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        let dismissAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(dismissAction)
        
        show(alert, sender: nil)
    }
    
    @objc func pressedDone(_ sender: UIButton) {
        view.endEditing(true)
        if let storyTitle = storyTitle {
            presenter?.createStory(title: storyTitle, contents: contents)
        } else {
            let alert = UIAlertController(title: nil, message: "Please enter the title of your story.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK.", style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            show(alert, sender: nil)
        }
    }
    
    @objc func beginEditing(_ notification: Notification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardRect.height - view.safeAreaInsets.bottom
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
                UIView.animate(withDuration: duration) {
                    self.bottomConstraint.constant = keyboardRect.height - self.view.safeAreaInsets.bottom
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func finishEditing(_ notification: Notification) {
        bottomConstraint.constant = 0
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            UIView.animate(withDuration: duration) {
                self.bottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension CreateViewController: CreateViewProtocol {
    func showLoading() {
        showIndicator()
    }
    
    func hideLoading() {
        dismissIndicator()
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showFailureAlert() {
        let alert = UIAlertController(title: "Failure", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK.", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension CreateViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        view.endEditing(true)
        switch item {
        case textBtn:
            switch editMode {
            case .SmallText where isTextEmpty():
                addContents(TempContents(type: .LargeText))
                textBtn.selectedImage = largeTextImage
                break
            default:
                addContents(TempContents(type: .SmallText))
                textBtn.selectedImage = smallTextImage
                break
            }
            break
        case quoteBtn:
            addContents(TempContents(type: .Quote))
            break
        case separatorBtn:
            addContents(TempContents(type: .Separator))
            break
        case imageBtn:
            openLibrary()
            break
        default:
            break
        }
    }
    
    func isTextEmpty() -> Bool {
        let cell = tableView.cellForRow(at: IndexPath(row: editIndex, section: 0))
        switch editMode {
        case .SmallText:
            if let cell = cell as? StorySmallTextEditCell {
                return cell.isEmpty()
            }
        case .LargeText:
            if let cell = cell as? StoryLargeTextEditCell {
                return cell.isEmpty()
            }
        case .Quote:
            if let cell = cell as? StoryQuoteEditCell {
                return cell.isEmpty()
            }
        default:
            return false
        }
        return false
    }
    
    func addContents(_ contents: TempContents) {
        if editIndex > 0 && isTextEmpty() {
            self.contents[editIndex - 1] = contents
        } else {
            self.contents.insert(contents, at: editIndex)
            editIndex += 1
        }
        
        if self.contents[editIndex - 1].type == .Separator {
            self.contents[editIndex - 1].contents = "Separator"
        }
        
        editMode = contents.type
//        tableView.insertRows(at: [IndexPath(row: editIndex, section: 0)], with: .automatic)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: editIndex, section: 0), at: .bottom, animated: true)
    }
}

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        showLoading()
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            
            let width: CGFloat = self.view.frame.width * 2.0
            let height: CGFloat = width * CGFloat(asset.pixelHeight) / CGFloat(asset.pixelWidth)
            
            manager.requestImage(for: asset, targetSize: CGSize(width: width, height: height), contentMode: .aspectFit, options: option) { result, info in
                if let image: UIImage = result {
                    if self.isTextEmpty() {
                        self.contents[self.editIndex - 1] = TempContents(image: image)
                    } else {
                        self.contents.insert(TempContents(image: image), at: self.editIndex)
                        self.editIndex += 1
                    }
                    self.editMode = .Image
//                    self.tableView.insertRows(at: [IndexPath(row: self.editIndex, section: 0)], with: .automatic)
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: self.editIndex, section: 0), at: .bottom, animated: true)
                }
                self.hideLoading()
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 44
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTitleEditCell.cellReuseIdentifier) as? StoryTitleEditCell else {
                return UITableViewCell()
            }
            cell.updateUI(storyTitle, delegate: self)
            return cell
        }
        switch contents[indexPath.row - 1].type {
        case .SmallText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StorySmallTextEditCell.cellReuseIdentifier) as? StorySmallTextEditCell else {
                return UITableViewCell()
            }
            cell.updateUI(contents[indexPath.row - 1].contents, at: indexPath.row, delegate: self)
            return cell
        case .LargeText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryLargeTextEditCell.cellReuseIdentifier) as? StoryLargeTextEditCell else {
                return UITableViewCell()
            }
            cell.updateUI(contents[indexPath.row - 1].contents, at: indexPath.row, delegate: self)
            return cell
        case .Quote:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryQuoteEditCell.cellReuseIdentifier) as? StoryQuoteEditCell else {
                return UITableViewCell()
            }
            cell.updateUI(contents[indexPath.row - 1].contents, at: indexPath.row, delegate: self)
            return cell
        case .Separator:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StorySeparatorCell.cellReuseIdentifier) as? StorySeparatorCell else {
                return UITableViewCell()
            }
            return cell
        case .Image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryImageCell.cellReuseIdentifier) as? StoryImageCell else {
                return UITableViewCell()
            }
            if let image: UIImage = contents[indexPath.row - 1].image {
                cell.updateUI(image: image, width: 414)
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
        if editIndex > 0 && editIndex <= contents.count && (contents[editIndex - 1].type == .Image || contents[editIndex - 1].type == .Separator) {
            view.endEditing(true)
        }
    }
}


protocol EditingTableViewDelegate {
    func changeHeight()
    func updateContents(at index: Int, contents: String)
    func updateEditIndex(to index: Int)
}

extension CreateViewController: EditingTableViewDelegate {
    
    func updateContents(at index: Int, contents: String) {
        if index == 0 {
            storyTitle = contents
        } else {
            self.contents[index - 1].contents = contents
        }
    }
    
    func changeHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateEditIndex(to index: Int) {
        if editIndex > 0 && index != editIndex && isTextEmpty() {
            self.contents.remove(at: editIndex - 1)
//            tableView.reloadData()
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: editIndex - 1, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
        if index == 0 {
            editMode = nil
        }
        
        self.editIndex = index
    }
}
