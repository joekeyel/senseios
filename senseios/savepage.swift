//
//  savepage.swift
//  senseios
//
//  Created by Hasanul Isyraf on 04/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class savepage: UIViewController {
    
    @IBOutlet weak var ratingremark: UITextView!
    @IBOutlet weak var smileyimage: UIImageView!
    
    var rating:String = ""
    var employeeinfo:employeemodel = employeemodel()

    override func viewDidLoad() {
        super.viewDidLoad()

        
            
            smileyimage.image = UIImage(named:rating)
        let myColor = UIColor.black
        ratingremark.layer.borderColor = myColor.cgColor
        ratingremark.layer.borderWidth = 1.0
        
        ratingremark.layer.cornerRadius = 5
        
    }
    

   
}
