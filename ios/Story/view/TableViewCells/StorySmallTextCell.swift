//
//  StorySmallTextCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/09.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class StorySmallTextCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Story Small Text Cell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(_ text: String, _ isHighlighted: Bool = false) {
        if isHighlighted {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia", size: 18)!, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.backgroundColor, value: UIColor.transparentMoss, range: (text as NSString).range(of: text))
            textLabel?.attributedText = attributedStr
        } else {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia", size: 18)!, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.backgroundColor, value: UIColor.clear, range: (text as NSString).range(of: text))
            textLabel?.attributedText = attributedStr
        }
    }
}
