//
//  DailyReadCell.swift
//  Medium
//
//  Created by 윤영일 on 05/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class DailyReadCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Daily Read Cell"
    static let height: CGFloat = 100.0
    
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var authorLab: UILabel!
    @IBOutlet weak var timeToReadLab: UILabel!
    @IBOutlet weak var storyImgView: UIImageView!
    @IBOutlet weak var publicationImgView: UIImageView!
    @IBOutlet weak var publicationView: UIView!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ story: DailyReadStory) {
        titleLab.text = story.title
        authorLab.text = story.author
        timeToReadLab.text = "\(story.timeToRead) min read"
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
    }
    
}
