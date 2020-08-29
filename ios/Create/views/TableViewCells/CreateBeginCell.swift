//
//  CreateBeginCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class CreateBeginCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Create Basic Cell"

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentsLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(title: String, contents: String) {
        showSeparator()
        titleLab.text = title
        contentsLab.text = contents
    }
}
