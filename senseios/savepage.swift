//
//  savepage.swift
//  senseios
//
//  Created by Hasanul Isyraf on 04/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class savepage: UIViewController {
    
    @IBOutlet weak var buttonsave: UIButton!
    @IBOutlet weak var bottomconstraint: NSLayoutConstraint!
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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        ratingremark.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let loginbuttony = ratingremark.frame.origin.y
            let framey = view.frame.size.height
            let distancemove = framey - (loginbuttony)-(keyboardRectangle.height)
            view.frame.origin.y =  -distancemove - bottomconstraint.constant
            
            print(loginbuttony)
            return
        }
        
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
        
        view.frame.origin.y = 0
    }
    
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
  
   
}
