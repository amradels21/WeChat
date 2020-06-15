//
//  ChatRoomViewController.swift
//  WEChat
//
//  Created by Amr Adel on 6/12/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chatMessages = [Message]()
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var chatTextField: UITextField!
    var room: Room?

    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = .none
        chatTableView.allowsSelection = false

        title = room?.roomName
        observeMessages()
        // Do any additional setup after loading the view.
    }
    
    func observeMessages(){
        guard let roomId = self.room?.roomId else{
            return
        }
        
        let reference = Database.database().reference()

        reference.child("rooms").child(roomId).child("messages").observe(.childAdded) { (snapchot) in
            
            if let dataArray = snapchot.value as? [String: Any] {
                guard let senderName = dataArray["senderName"] as? String, let messageText = dataArray["text"] as? String, let senderId = dataArray["senderId"] as? String else {
                    
                    return
                }
                
                let message = Message.init(messageKey: snapchot.key, SenderName: senderName, messageText: messageText, userId: senderId)
                self.chatMessages.append(message)
                self.chatTableView.reloadData()
                
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let message = self.chatMessages[indexPath.row]
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatCell") as! ChatCell
        cell.setMessageData(message: message)
     
        if(message.userId == Auth.auth().currentUser!.uid){
            cell.setBubbleType(type: .outgoing)
        }else{
            cell.setBubbleType(type: .incoming)
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessages.count
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
                if let roomId = self.room?.roomId, let senderId = Auth.auth().currentUser?.uid {
                    let dataArray: [String: Any] = ["senderName": userName, "text": text, "senderId": senderId ]
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
