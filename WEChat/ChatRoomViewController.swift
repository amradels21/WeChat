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
          guard let chatText = self.chatTextField.text, chatText.isEmpty == false
               else {
              return
          }
          
          //Send and verify that message is send by the completion block
          sendMessage(text: chatText) { (isSuccess) in
              if(isSuccess){
                print("Message Sent!")
              }
          }
      }
    
    func getUsernameWithId(id: String, completion: @escaping (_ userName: String?) -> () ){
        
        let reference = Database.database().reference()
        let user = reference.child("users").child(id)
               
        user.child("username").observeSingleEvent(of: .value) { (snapshot) in
            if let userName = snapshot.value as? String {
                completion(userName)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func sendMessage(text: String, completion: @escaping (_ isSuccess: Bool) -> () ){
        guard let userId = Auth.auth().currentUser?.uid else{
            return
            
        }
        let reference = Database.database().reference()
        let user = reference.child("users").child(userId)
       
        getUsernameWithId(id: userId) { (userName) in
            if let userName = userName{
                if let roomId = self.room?.roomId {
                    let dataArray: [String: Any] = ["senderName": userName, "text": text]
                        let room = reference.child("rooms").child(roomId)
                            room.child("messages").childByAutoId().setValue(dataArray) { (error, ref) in
                            if(error == nil){
                                completion(true)
                                self.chatTextField.text = ""
                                print("Room added to database Successfully")
                                     }
                            else{
                                completion(false)
                                   
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
