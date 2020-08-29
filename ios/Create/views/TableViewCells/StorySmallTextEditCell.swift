//
//  StorySmallTextEditCell.swift
//  Medium
//
//  Created by 윤영일 on 2019/10/10.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class StorySmallTextEditCell: UITableViewCell {

    static let cellReuseIdentifier: String = "Story Small Text Edit Cell"
    private let placeholder: String = "Please input text."
    
    var index: Int?
    var delegate: EditingTableViewDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let attributedStr = NSMutableAttributedString.init(string: placeholder)
        attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (placeholder as NSString).range(of: placeholder))
        attributedStr.addAttribute(.font, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 0, length: placeholder.count))
        
        textView.attributedText = attributedStr
        
        textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isEmpty() -> Bool {
        return (textView.textColor == .lightGray) || ((textView.text ?? "").trimmingCharacters(in: [" "]) == "")
    }
    
    func updateUI(_ text: String?, at index: Int, delegate: EditingTableViewDelegate) {
        textView.text = text ?? placeholder
        textView.textColor = (text != nil) ? .black : .lightGray
        
        self.index = index
        self.delegate = delegate
    }
    
}

extension StorySmallTextEditCell: UITextViewDelegate {
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
        if let index = index {
            delegate?.updateEditIndex(to: index)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewSetupView()
        if let index = index, !isEmpty() {
            delegate?.updateContents(at: index, contents: textView.text)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
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
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 0, length: temp.count))
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 6
            attributedStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: temp.count))
            textView.attributedText = attributedStr
            textView.text = ""
        } else if textView.text == "" {
            let attributedStr = NSMutableAttributedString.init(string: placeholder)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: placeholder.count))
            attributedStr.addAttribute(.font, value: UIFont(name: "Georgia", size: 18.0)!, range: NSRange(location: 0, length: placeholder.count))
            textView.attributedText = attributedStr
        }
    }
}
