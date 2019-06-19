//
//  menucontroller2.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 27/09/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class menucontroller2: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var profileimage: UIImageView!
    
    var tableitem = ["Home","Search","Profile","Generate QR","Maps","Notification-1","Sign Out"];
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
     
        profileimage.layer.cornerRadius = 50
        
        loadimageprofile()

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableitem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! menucell
        
        
        cell.imageitem.image = UIImage(named:tableitem[indexPath.row])
        cell.itemtext.text = tableitem[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableitem[indexPath.row] == "Sign Out"){
            
            try! Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "startpage") as! startpagecontroller
            
            
            
            self.present(initialViewController2, animated: true)
            
          
            
            
      
        }else{
              self.performSegue(withIdentifier: tableitem[indexPath.row], sender: self)
            
        }
        
    }

    
    func loadimageprofile(){
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        profileimage?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        profileimage?.contentMode = UIViewContentMode.scaleAspectFit
        
        
        let islandRef = storageRef.child("senseprofile/"+(Auth.auth().currentUser?.uid)!+".jpg")
        
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
                
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                
                self.profileimage?.image = image
            }
        }
    }

}
