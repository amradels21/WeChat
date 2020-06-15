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
    
    enum bubbleType {
        case incoming
        case outgoing
    }
    
    @IBOutlet weak var chatTextBubble: UIView!
    
    @IBOutlet weak var chatStack: UIStackView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var chatTextView: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        // Initialization code
        
    }
    
    func setBubbleType(type: bubbleType){
        if(type == .incoming){
            chatStack.alignment = .leading
            chatTextBubble.backgroundColor = #colorLiteral(red: 1, green: 0.7606711113, blue: 0.2461192648, alpha: 1)
            chatTextView.textColor = .black
        }
        else if(type == .outgoing){
            chatStack.alignment = .trailing
            chatTextBubble.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            chatTextView.textColor = .white
        }
    }
    
    func setMessageData(message: Message){
        userNameLabel.text = message.SenderName
        chatTextView.text = message.messageText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
