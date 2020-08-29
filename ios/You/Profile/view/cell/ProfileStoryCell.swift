//
//  ProfileStoryCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/11.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileStoryCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Profile Story Cell"
    static let height: CGFloat = 156.0
    
    var delegate: ReadingListViewProtocol?
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentsLab: UILabel!
    @IBOutlet weak var authorLab: UILabel!
    @IBOutlet weak var inLab: UILabel!
    @IBOutlet weak var publicationLab: UILabel!
    @IBOutlet weak var createdAtLab: UILabel!
    @IBOutlet weak var timeToReadLab: UILabel!
    @IBOutlet weak var storyImgView: UIImageView!
    @IBOutlet weak var publicationImgView: UIImageView!
    @IBOutlet weak var publicationView: UIView!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(story: ProfileStory, view: ReadingListViewProtocol? = nil, indexPath: IndexPath) {
        delegate = view
        self.indexPath = indexPath
        
        titleLab.text = story.title.trimmingCharacters(in: [" ", "\n", "\r"])
        if let contents = story.contents?.trimmingCharacters(in: [" ", "\n", "\r"]) {
            contentsLab.isHidden = false
            contentsLab.textColor = .black
            contentsLab.text = contents
        } else {
            contentsLab.isHidden = true
        }
        
        let width: CGFloat = (story.storyImageUrlAddr != nil) ? (414 - 130) : (414 - 40)
        if !contentsLab.isHidden && titleLab.sizeThatFits(CGSize(width: width, height: CGFloat(MAXFLOAT))).height > 60 {
            contentsLab.isHidden = true
        }
        
        authorLab.text = story.author
        createdAtLab.text = story.createdDate.toString()
        timeToReadLab.text = "\(story.timeToRead) min read"
        if let publication: String = story.publication {
            inLab.isHidden = false
            publicationLab.isHidden = false
            publicationLab.text = publication
        } else {
            inLab.isHidden = true
            publicationLab.isHidden = true
        }
        if let imageUrlAddr: String = story.storyImageUrlAddr {
            trailingConstraint.constant = 25 + storyImgView.frame.width + 20
            storyImgView.isHidden = false
            storyImgView.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
            
            if let imageUrlAddr: String = story.authorImageUrlAddr {
                publicationView.isHidden = false
                publicationImgView.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
            } else {
                publicationView.isHidden = true
            }
        } else {
            trailingConstraint.constant = 20
            storyImgView.isHidden = true
            publicationView.isHidden = true
        }
        switch story.readingType {
        case .save:
            bookmarkBtn.setImage(UIImage(systemName: "archivebox"), for: .normal)
        case .archive:
            bookmarkBtn.setImage(UIImage(systemName: "bin.xmark"), for: .normal)
        case .none:
            bookmarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    @IBAction func pressedSaveBtn(_ sender: UIButton) {
        delegate?.pressedBtn(indexPath!)
    }
    
}
