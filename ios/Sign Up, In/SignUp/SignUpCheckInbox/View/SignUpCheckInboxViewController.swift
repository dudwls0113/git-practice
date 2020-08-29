//
//  SignUpCheckInbox.swift
//  Medium
//
//  Created by 윤영일 on 04/10/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit

class SignUpCheckInboxViewController: BaseViewController {
    
    @IBOutlet weak var emailLab: UILabel!
    
    override func viewDidLoad() {
        //
        
    }
    
    @IBAction func pressedDismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
