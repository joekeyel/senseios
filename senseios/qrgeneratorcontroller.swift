//
//  selectactivitycontroller.swift
//  senseios
//
//  Created by Hasanul Isyraf on 03/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class qrgeneratorcontroller: UIViewController {

    @IBOutlet weak var nextpageactivity: UIButton!
    @IBOutlet weak var remarkactivity: UITextView!
    
    var employeeinfo:employeemodel = employeemodel()
    
   
    @IBOutlet weak var menuitem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor.black
        remarkactivity.layer.borderColor = myColor.cgColor
      remarkactivity.layer.borderWidth = 1.0
       
        remarkactivity.layer.cornerRadius = 5
        
        remarkactivity.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        remarkactivity.addGestureRecognizer(tapGesture)
        
        
        nextpageactivity.layer.cornerRadius = 10
        
        //this part to move the view above the keyboard when keyboard is showed up
        
      
        
        
        menuitem.target = self.revealViewController()
        menuitem.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
      
    }
    
    
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
       
    }
    
    @IBAction func selectcallaction(_ sender: Any) {
        
        employeeinfo.activity = "call"
        employeeinfo.activityremark = remarkactivity.text
        
      
        
        
    }
    
    
    @IBAction func selectemailaction(_ sender: Any) {
        
        employeeinfo.activity = "email"
          employeeinfo.activityremark = remarkactivity.text
    }
    
    
    @IBAction func selectmeetingaction(_ sender: Any) {
        employeeinfo.activity = "meeting"
          employeeinfo.activityremark = remarkactivity.text
    }
    
    
    @IBAction func selectworkshopaction(_ sender: Any) {
        employeeinfo.activity = "workshop"
          employeeinfo.activityremark = remarkactivity.text
    }
    
    @IBAction func selectothersaction(_ sender: Any) {
        employeeinfo.activity = "others"
          employeeinfo.activityremark = remarkactivity.text
    }
    
    
    @IBAction func nextbutton(_ sender: Any) {
        
        employeeinfo.activityremark = remarkactivity.text
        
        if(!(remarkactivity.text?.isEmpty)! && !(employeeinfo.activity?.isEmpty)!){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "qrimage") as! qrgeneratorimage
            
            
            initialViewController2.activity = employeeinfo.activity!
            initialViewController2.activityremark = remarkactivity.text
            
            self.navigationController?.pushViewController(initialViewController2, animated: true)
        }else{
            
            
            showToast(message: "Pls select activity and insert your remark")
        }
    }
   
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let loginbuttony = remarkactivity.frame.origin.y
            let framey = view.frame.size.height
            let distancemove = framey - (loginbuttony)-(keyboardRectangle.height)
            view.frame.origin.y =  -distancemove
            
            print(loginbuttony)
            return
        }
        
        
        
    }
    
   
    
  
    
    
}
