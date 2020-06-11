//
//  RoomsViewController.swift
//  WEChat
//
//  Created by Amr Adel on 6/11/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressLogout(_ sender: UIBarButtonItem) {
        let formScreen = self.storyboard?.instantiateViewController(identifier: "LoginScreen") as! ViewController
        self.present(formScreen, animated: true, completion: nil)
        
        
        
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
