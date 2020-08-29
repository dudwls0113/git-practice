//
//  UITextField.swift
//  Medium
//
//  Created by 윤영일 on 03/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

extension UITextField {
    func addUnderline(_ color: UIColor = .black) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.width, height: 1)
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
    }
}
