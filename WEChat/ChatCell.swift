//
//  ChatCell.swift
//  WEChat
//
//  Created by Amr Adel on 6/13/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit
import Firebase

class ChatCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var chatTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
