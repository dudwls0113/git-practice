//
//  StoryTitleEditCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class StoryTitleEditCell: UITableViewCell {
    
    static let cellReuseIdentifier: String = "Story Title Edit Cell"
    private let placeholder: String = "Please input the title."
    
    var delegate: EditingTableViewDelegate?
    
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textView.delegate = self
        
        let attributedStr = NSMutableAttributedString.init(string: placeholder)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (placeholder as NSString).range(of: placeholder))
        attributedStr.addAttribute(.font, value: UIFont(name: "Georgia-Bold", size: 25.0)!, range: NSRange(location: 0, length: placeholder.count))
        textView.attributedText = attributedStr
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isEmpty() -> Bool {
        if (textView.textColor == .lightGray) || (textView.text ?? "").trimmingCharacters(in: [" "]) == "" {
            return true
        }
        return false
    }
    
    func updateUI(_ text: String?, delegate: EditingTableViewDelegate) {
        textView.text = text ?? placeholder
        textView.textColor = (text != nil) ? .black : .lightGray
        
        self.delegate = delegate
    }
}

extension StoryTitleEditCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
        delegate?.updateEditIndex(to: 0)
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewSetupView()
        if !isEmpty() {
            delegate?.updateContents(at: 0, contents: textView.text)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let lastChar = textView.text.last, lastChar == "\n" {
            textView.text = textView.text.substring(from: 0, to: textView.text.count - 1)
            textView.resignFirstResponder()
        }
        
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            textView.bounds.size.height = newSize.height
            UIView.setAnimationsEnabled(false)
            delegate?.changeHeight()
            UIView.setAnimationsEnabled(true)
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView.text == "\n" {
//            textView.resignFirstResponder()
//        }
//        return true
//    }
    
    func textViewSetupView() {
        if textView.text == placeholder {
            let temp = " "
            let attributedStr = NSMutableAttributedString.init(string: temp)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: temp.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia-Bold", size: 25.0)!, range: NSRange(location: 0, length: temp.count))
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: temp.count))
            textView.attributedText = attributedStr
            textView.text = ""
        } else if textView.text == "" {
            let attributedStr = NSMutableAttributedString.init(string: placeholder)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: placeholder.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia-Bold", size: 25.0)!, range: NSRange(location: 0, length: placeholder.count))
            textView.attributedText = attributedStr
        }
    }
}

