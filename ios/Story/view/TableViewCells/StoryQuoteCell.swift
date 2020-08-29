//
//  StoryQuoteCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class StoryQuoteCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Story Quote Cell"
        
    @IBOutlet weak var textLab: UILabel!
    
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
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia-Bold", size: 20)!, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.backgroundColor, value: UIColor.transparentMoss, range: (text as NSString).range(of: text))
            textLab.attributedText = attributedStr
        } else {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia-Bold", size: 20)!, range: NSRange(location: 0, length: text.count))
            attributedStr.addAttribute(.backgroundColor, value: UIColor.clear, range: (text as NSString).range(of: text))
            textLab?.attributedText = attributedStr    
       }
    }
}
