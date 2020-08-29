//
//  RecommendationCell.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendationCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Recommendation Cell"
    static let heightWithTopic: CGFloat = 180.0
    static let heightWithoutTopic: CGFloat = RecommendationCell.heightWithTopic - 24.0
    
    var delegate: MainViewProtocol?
    var indexPath: IndexPath?
    
    @IBOutlet weak var topicLab: UILabel!
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
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(story: RecommendationStory, view: MainViewProtocol, indexPath: IndexPath) {
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
        if let topic: String = story.topic {
            topicLab.isHidden = false
            topicLab.text = topic
            topConstraint.constant = 20 + 16 + 10
        } else {
            topicLab.isHidden = true
            topConstraint.constant = 20
        }
        if let imageUrlAddr: String = story.storyImageUrlAddr {
            trailingConstraint.constant = 25 + storyImgView.frame.width + 20
            storyImgView.isHidden = false
            storyImgView.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
            
            if let imageUrlAddr: String = story.publicationImageUrlAddr {
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
        bookmarkBtn.setImage(UIImage(systemName: story.isSaved ? "bookmark.fill" : "bookmark"), for: .normal) 
    }
    
    @IBAction func pressedSaveBtn(_ sender: UIButton) {
        delegate?.pressedSaveBtn(indexPath!)
    }
    
    @IBAction func pressedMoreBtn(_ sender: UIButton) {
        delegate?.pressedMoreBtn(indexPath!)
    }
}
