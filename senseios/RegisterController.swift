//
//  RegisterController.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 30/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    
    @IBOutlet weak var iconimage: UIImageView!
    
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var passwordedittext: UITextField!
    @IBOutlet weak var usernameedittext: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let usernameimage = UIImage(named:"Profile")
        let passwordimage = UIImage(named:"password")
        
        addLeftimage(textfield: usernameedittext, addimg: usernameimage!)
        addLeftimage(textfield: passwordedittext, addimg: passwordimage!)
        
        iconimage.image = UIImage(named:"react")
        
      
    }
    

    @IBAction func registeraction(_ sender: Any) {
        
        
        
        if (!(usernameedittext.text?.isEmpty)!){
            Auth.auth().createUser(withEmail: usernameedittext.text!, password: passwordedittext.text!) {(user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.showToast(message: error.localizedDescription)
                }
                else {
                    print("User signed in!")
                    
                    Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                          print("Email sent")
                        self.showToast(message: "Verification Email has been sent")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "login") as! LoginController
                        initialViewController2.msgfromregister = "Verification Email has been sent"
                        
                        
                        self.present(initialViewController2, animated: true)
                        
                        
                    })

                    //At this point, the user will be taken to the next screen
                }
            } }
        else{
            
            showToast(message: "You left email/password empty")
        }
    }
    
    
//    deinit{
//
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardWillShow)
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardDidShow)
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardWillChangeFrame)
//
//    }
    //function obj c when keyboard shown up
    
    @objc func keyboardWillShow(notification: NSNotification) {
      
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let loginbuttony = registerbutton.frame.origin.y
            let framey = view.frame.size.height
            let distancemove = framey - (loginbuttony)-(keyboardRectangle.height)
            view.frame.origin.y =  -distancemove
              print(loginbuttony)
            return
        }
        
        
        

        
        
    }
    
   
    
    //this is when user tap to dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func addLeftimage(textfield:UITextField,addimg:UIImage){
        let leftimageview = UIImageView(frame:CGRect(x:0.0,y:0.0,width:addimg.size.width,height:addimg.size.height))
        leftimageview.image = addimg
        
        textfield.leftView = leftimageview
        textfield.leftViewMode = .always
        
        
    }
}
