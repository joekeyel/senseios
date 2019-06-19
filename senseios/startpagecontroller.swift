//
//  homecontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 27/09/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class startpagecontroller: UIViewController {
    
    
    @IBOutlet weak var shopchartbar: UIBarButtonItem!
    @IBOutlet weak var notificationbar: UIBarButtonItem!
    
    @IBOutlet weak var menubutton: UIBarButtonItem!
    
    var pushnotification:Bool = false

    @IBOutlet weak var getstarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        getstarted.layer.cornerRadius = 10
       
     
        let imagebg:UIImage = UIImage(named:"background")!
        let imagebgresize = resizeToScreenSize(image: imagebg)
        
       
        self.view.backgroundColor = UIColor(patternImage:imagebgresize )
        
        
    
        
      
      
        
    }
   
    

    @IBAction func gotosearch(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "login") as! LoginController
        
        
        
        self.present(initialViewController2, animated: false)
        
    }
    
    func resizeToScreenSize(image: UIImage)->UIImage{
        
        let screenSize = self.view.bounds.size
        
        
        return resizeImage(image: image, newWidth: screenSize.width)
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
    
}




