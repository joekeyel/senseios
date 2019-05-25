//
//  selectactivitycontroller.swift
//  senseios
//
//  Created by Hasanul Isyraf on 03/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class selectactivitycontroller: UIViewController,UITextViewDelegate{

    @IBOutlet weak var nextpageactivity: UIButton!
    @IBOutlet weak var remarkactivity: UITextView!
     
    
    var employeeinfo:employeemodel = employeemodel()
    
   
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       remarkactivity.delegate = self
        let myColor = UIColor.black
        remarkactivity.layer.borderColor = myColor.cgColor
      remarkactivity.layer.borderWidth = 1.0
       
        remarkactivity.layer.cornerRadius = 5
        
        
        remarkactivity.isUserInteractionEnabled = true
        remarkactivity.text = "Please Double tab to enter description of the activity"
        remarkactivity.textColor = UIColor.lightGray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        remarkactivity.addGestureRecognizer(tapGesture)
        
        
        nextpageactivity.layer.cornerRadius = 10
        
        //this part to move the view above the keyboard when keyboard is showed up
        
      
        
        employeeinfo.activity = ""
      
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
        
        if(remarkactivity.text.isEmpty){
            
             showToast(message: "Pls insert your remark")
            
        }else if(employeeinfo.activity == ""){
            
             showToast(message: "Pls select activity ")
            
        }else if(remarkactivity.text.elementsEqual("Please Double tab to enter description of the activity")){
            
             showToast(message: "Pls insert your remark")
            
        }
        
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectsmiley") as! selectsmiley
            
            
            initialViewController2.employeeinfo = employeeinfo
            
            self.navigationController?.pushViewController(initialViewController2, animated: true)
            
        }
        
      
    }
   
    
    
    @objc func keyboardWillShow(notification: NSNotification) {


        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle =  keyboardFrame.cgRectValue.height
            let remarkposition = remarkactivity.frame.origin.y + 50
            let framey = view.frame.size.height


            let distancemove = framey - (remarkposition)-(keyboardRectangle)
            view.frame.origin.y =  -distancemove

            print("remark:\(remarkposition)")
            print("keyboard height\(keyboardRectangle)")
            return
        }



    }

   
    
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//                self.view.frame.origin.y += remarkactivity.frame.origin.y
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        if remarkactivity.textColor == UIColor.lightGray {
            remarkactivity.text = nil
            remarkactivity.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if remarkactivity.text.isEmpty {
            remarkactivity.text = "Please Double tab to enter description of the activity"
            remarkactivity.textColor = UIColor.lightGray
        }
    }
    
}
