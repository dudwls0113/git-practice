//
//  StoryImageCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class StoryImageCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Story Image Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(image: UIImage, width: CGFloat) {
        imageView?.image = image
        imageView?.snp.makeConstraints { make in
            make.top.top.equalTo(10)
            make.bottom.bottom.equalTo(-10)
            make.leading.leading.equalTo(20)
            make.trailing.trailing.equalTo(-20)
            make.height.equalTo((width - 20) * (imageView!.image!.size.height / imageView!.image!.size.width))
        }
    }
    
    func updateUI(imageUrlAddr: String, width: CGFloat) {
        imageView?.contentMode = .scaleAspectFit
        imageView?.kf.setImage(with: URL(string: imageUrlAddr), placeholder: UIImage.placeholder)

        imageView?.snp.makeConstraints { make in
            make.top.top.equalTo(10)
            make.bottom.bottom.equalTo(-10)
            make.leading.leading.equalTo(20)
            make.trailing.trailing.equalTo(-20)
            make.height.equalTo((width - 40) * (imageView!.image!.size.height / imageView!.image!.size.width))
        }
    }
}
