//
//  StoryTitleCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Kingfisher

class StoryTitleCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Story Title Cell"
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var subtitleLab: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorLab: UILabel!
    @IBOutlet weak var inLab: UILabel!
    @IBOutlet weak var publicationLab: UILabel!
    @IBOutlet weak var createdAtLab: UILabel!
    @IBOutlet weak var timeToReadLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ story: Story) {
        titleLab.text = story.title
        if let subtitle = story.subtitle {
            subtitleLab.isHidden = false
            subtitleLab.text = subtitle
        } else {
            subtitleLab.isHidden = true
        }
        if let imageUrlAddr = story.authorImageUrlAddr {
            authorImage.isHidden = false
            authorImage.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
        } else {
            authorImage.isHidden = true
        }
        if let imageUrlAddr = story.authorImageUrlAddr {
            authorImage.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)
        }
        authorLab.text = story.author
        if let publication: String = story.publication {
            inLab.isHidden = false
            publicationLab.isHidden = false
            publicationLab.text = publication
        } else {
            inLab.isHidden = true
            publicationLab.isHidden = true
        }        
        createdAtLab.text = story.createdDate.toString()
        timeToReadLab.text = "\(story.timeToRead) min read"
    }
}
