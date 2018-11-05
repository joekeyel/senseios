//
//  profilecontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 03/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class profilecontroller: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
  
    
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var menubutton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
       
        
        loadimageprofile()
    }
    
    
    
    @IBAction func uploadprofilepic(_ sender: Any) {
        
        
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title:"Photo Source",message:"Choose a source",preferredStyle:.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title:"Camera",style:.default,handler:{(action:UIAlertAction) in
            
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller,animated: true,completion: nil)
            
        }))
        
        actionsheet.addAction(UIAlertAction(title:"Photo Library",style:.default,handler:{(action:UIAlertAction) in
            
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller,animated: true,completion: nil)
            
        }))
        
        actionsheet.addAction(UIAlertAction(title:"Cancel",style:.cancel,handler:nil))
        
        self.present(actionsheet,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        profileimage.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        profileimage?.contentMode = UIViewContentMode.scaleAspectFit
        
        profileimage.image = resizeToScreenSize(image: image)
        
        picker.dismiss(animated: true, completion: nil)
       uploadimage()
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resizeToScreenSize(image: UIImage)->UIImage{
        
        let screenSize = self.view.bounds.size
        
        
        return resizeImage(image: image, newWidth: screenSize.width)
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
    
    
    
    func uploadimage(){
        
        // Create a root reference
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        
            
            profileimage.image = resizeImage(image: profileimage.image!, newWidth: 800)
        
        
            let uid : String = (Auth.auth().currentUser?.uid)!
            // Create a reference to the file you want to upload
     
            
            // Upload the file to the path "images/rivers.jpg"
        var data = Data()
        
         data = UIImageJPEGRepresentation(profileimage.image!, 0.8)!
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("senseprofile/"+uid+".jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: metaData) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
                
               
               
                
            
        }
        
        
    }

