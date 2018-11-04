//
//  selectactivitycontroller.swift
//  senseios
//
//  Created by Hasanul Isyraf on 03/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class selectactivitycontroller: UIViewController {

    @IBOutlet weak var remarkactivity: UITextView!
    
    var employeeinfo:employeemodel = employeemodel()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor = UIColor.black
        remarkactivity.layer.borderColor = myColor.cgColor
      remarkactivity.layer.borderWidth = 1.0
       
        remarkactivity.layer.cornerRadius = 5
        
        remarkactivity.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        remarkactivity.addGestureRecognizer(tapGesture)
    }
    
    
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
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
    
    
    @IBAction func nextpageaction(_ sender: Any) {
        
         employeeinfo.activityremark = remarkactivity.text
        
        if(!(employeeinfo.activityremark?.isEmpty)! && !(employeeinfo.activity?.isEmpty)!){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectsmiley") as! selectsmiley
            
            
            initialViewController2.employeeinfo = employeeinfo
            
            self.navigationController?.pushViewController(initialViewController2, animated: true)
        }else{
            
            
            showToast(message: "Pls select activity and insert your remark")
        }
        
    }
}
