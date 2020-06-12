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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomTable.delegate = self
        self.roomTable.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell")!
        cell.textLabel?.text = "Hello"
        
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
