//
//  DailyAlreadyReadCell.swift
//  Medium
//
//  Created by 윤영일 on 06/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class DailyAlreadyReadCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Daily Already Read Cell"
    static let height: CGFloat = 60

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ story: DailyReadStory) {
        textLabel?.text = story.title
    }
}
