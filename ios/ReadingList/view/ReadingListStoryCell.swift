//
//  ReadingListStoryCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/12.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Kingfisher

class ReadingListStoryCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Reading List Story Cell"
    
    var delegate: ReadingListViewProtocol?
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentsLab: UILabel!
    @IBOutlet weak var authorLab: UILabel!
    @IBOutlet weak var inLab: UILabel!
    @IBOutlet weak var publicationLab: UILabel!
    @IBOutlet weak var createdAtLab: UILabel!
    @IBOutlet weak var timeToReadLab: UILabel!
    @IBOutlet weak var storgImg: UIImageView!
    @IBOutlet weak var saveArchiveBtn: UIButton!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(story: ReadingListStory, isSaved: Bool, view: ReadingListViewProtocol, indexPath: IndexPath) {
        delegate = view
        self.indexPath = indexPath
        
        titleLab.text = story.title.trimmingCharacters(in: [" ", "\n", "\r"])
        if let subTitle = story.subTitle?.trimmingCharacters(in: [" ", "\n", "\r"]) {
            contentsLab.isHidden = false
            contentsLab.textColor = .black
            contentsLab.text = subTitle
        } else {
            contentsLab.isHidden = true
        }
        
        let width: CGFloat = (story.imageUrlAddr != nil) ? (414 - 130) : (414 - 40)
        if !contentsLab.isHidden && titleLab.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT))).height > 60 {
            contentsLab.isHidden = true
        }
        
        authorLab.text = story.name
        createdAtLab.text = story.createAt.toString()
        timeToReadLab.text = "\(story.timeToRead) min read"
        
        if let publications: String = story.publications {
            inLab.isHidden = false
            publicationLab.isHidden = false
            publicationLab.text = publications
        } else {
            inLab.isHidden = true
            publicationLab.isHidden = true
        }
        
        if let imageUrlAddr: String = story.imageUrlAddr {
            trailingConstraint.constant = 110
            storgImg.isHidden = false
            storgImg.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
        } else {
            trailingConstraint.constant = 20
            storgImg.isHidden = true
        }
        
        switch story.readingType {
        case .save:
            saveArchiveBtn.setImage(UIImage(systemName: "archivebox"), for: .normal)
        case .archive:
            saveArchiveBtn.setImage(UIImage(systemName: "bin.xmark"), for: .normal)
        case .none:
            saveArchiveBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    @IBAction func pressedSavedBtn(_ sender: UIButton?) {
        if let indexPath = indexPath {
            delegate?.pressedBtn(indexPath)
        }
    }
}
