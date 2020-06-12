//
//  ChatRoomViewController.swift
//  WEChat
//
//  Created by Amr Adel on 6/12/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController {

    @IBOutlet weak var chatTextField: UITextField!
    var room: Room?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressSendBtn(_ sender: UIButton) {
        guard let chatText = self.chatTextField.text, chatText.isEmpty == false,
            let userId = Auth.auth().currentUser?.uid  else {
            return
        }
        
        let reference = Database.database().reference()
        let user = reference.child("users").child(userId)
        
        user.child("username").observeSingleEvent(of: .value) { (snapshot) in
            if let userName = snapshot.value as? String{
                if let roomId = self.room?.roomId {
                    
                    let dataArray: [String: Any] = ["senderName": userName, "text": chatText]
                    let room = reference.child("rooms").child(roomId)
                    room.child("messages").childByAutoId().setValue(dataArray) { (error, ref) in
                        if(error == nil){
                            self.chatTextField.text = ""
                            print("Room added to database Successfully")
                        }
                    }
                }
            }
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
