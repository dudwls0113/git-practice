//
//  ProfileCell.swift
//  Medium
//
//  Created by 윤영일 on 07/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    static let cellReuseIdentifier: String = "Profile Cell"
    static let height: CGFloat = 80
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(name: String, imageUrlAddr: String? = nil) {
        nameLab.text = name
        if let imageUrlAddr = imageUrlAddr {
            profileImg.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage(systemName: "person.crop.circle.fill"))
        }
    }
    
}
