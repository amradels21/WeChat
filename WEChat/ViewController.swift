//
//  ViewController.swift
//  WEChat
//
//  Created by Amr Adel on 6/11/20.
//  Copyright © 2020 Patatas. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let reference = Database.database().reference()
        let rooms = reference.child("roomsTest")
        rooms.setValue("Hello World")
        
        // Do any additional setup after loading the view.
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  self.collectionView.dequeueReusableCell(withReuseIdentifier: "formCell", for: indexPath) as! FormCell
        
        if (indexPath.row == 0) { //Sign in Cell
            cell.userNameContainer.isHidden = true
            cell.Actionbtn.setTitle("Login", for: .normal)
            cell.Slidebtn.setTitle("Sign Up ", for:  .normal)
            cell.Slidebtn.addTarget(self, action: #selector(slideToSignInCell(_:)), for: .touchUpInside)
        }
        else if(indexPath.row == 1){ //Sign Up Cell 
            cell.userNameContainer.isHidden = false
            cell.Actionbtn.setTitle("Sign Up", for: .normal)
            cell.Slidebtn.setTitle("Sign In ", for:  .normal)
            cell.Slidebtn.addTarget(self, action: #selector(slideToSignUpCell(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func slideToSignInCell(_ sender: UIButton){
        let indexPath = IndexPath(row: 1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
    }
    
    @objc func slideToSignUpCell(_ sender: UIButton){
          let indexPath = IndexPath(row: 0, section: 0)
          self.collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally], animated: true)
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.frame.size 
    }


}

