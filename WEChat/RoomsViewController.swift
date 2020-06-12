//
//  RoomsViewController.swift
//  WEChat
//
//  Created by Amr Adel on 6/11/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit
import Firebase

class RoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roomTable: UITableView!
    
    @IBOutlet weak var newRoomTextField: UITextField!
    var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomTable.delegate = self
        self.roomTable.dataSource = self
        observeRooms()

        // Do any additional setup after loading the view.
    }
    
    //Observe to rooms created to tableView
    func observeRooms(){
        let reference = Database.database().reference()
        reference.child("rooms").observe(.childAdded) { (snapshot) in
            if let dataArray = snapshot.value as? [String: Any] {
                if let roomName = dataArray["roomName"] as? String {
                    let room = Room.init(roomName: roomName)
                    self.rooms.append(room)
                    self.roomTable.reloadData()
                }
            }
            
        }
    }
    
    
    @IBAction func didPressCreateRoom(_ sender: UIButton) {
        guard let roomName = self.newRoomTextField.text, roomName.isEmpty == false else{
            return
        }
        let reference = Database.database().reference()
        let room = reference.child("rooms").childByAutoId()
        
        let dataArray: [String: Any] = ["roomName": roomName]
        room.setValue(dataArray) { (error, ref) in
            if(error == nil){
                self.newRoomTextField.text = ""
            }
         
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get Room of every cells index
        let room = self.rooms[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell")!
        cell.textLabel?.text = room.roomName
        
        return cell
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if ( Auth.auth().currentUser == nil) {
            self.showLoginScreen()
        }
    }
    
    func showLoginScreen(){
        let formScreen = self.storyboard?.instantiateViewController(identifier: "LoginScreen") as! ViewController
             self.present(formScreen, animated: true, completion: nil)
    }
    
    @IBAction func didPressLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        self.showLoginScreen()
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
