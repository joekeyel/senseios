//
//  LoginController.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 28/09/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase


class LoginController: UIViewController {

    @IBOutlet var popoverreset: UIView!
    @IBOutlet weak var usernametext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    @IBOutlet weak var appicon: UIImageView!
    
    var msgfromregister:String = ""
    var pushnotification:Bool = false
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        let usernameimage = UIImage(named:"Profile")
        let passwordimage = UIImage(named:"password")
        
        addLeftimage(textfield: usernametext, addimg: usernameimage!)
        addLeftimage(textfield: passwordtext, addimg: passwordimage!)
        
        appicon.image = UIImage(named:"react")
        
        
        print(msgfromregister)
        
            showToast(message: msgfromregister)
        

       
       
        
     
    }
    
    func emailcallback(){
        
        
    }
    


    @IBAction func loginactioN(_ sender: Any) {
        
        if (!(usernametext.text?.isEmpty)!){
            Auth.auth().signIn(withEmail: usernametext.text!, password: passwordtext.text!) {(user, error) in
                if let error = error {
                    print(error.localizedDescription)
                                   self.showToast(message: error.localizedDescription)
                }
                else {
                  
                    if((Auth.auth().currentUser?.isEmailVerified)!){
                        
                        
                        
                            
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "reveal") as! SWRevealViewController
                        var initialViewController3 = UIViewController()
                        
                        
                        if(self.pushnotification){
                            initialViewController3 = storyboard.instantiateViewController(withIdentifier: "notification") as! notification
                        }
                            
                        else{
                            
                            initialViewController3 = storyboard.instantiateViewController(withIdentifier: "searchemployee") as! searchcontroller
                            
                        }
                        let navigationController:UINavigationController = UINavigationController(rootViewController: initialViewController3)
                        
                        initialViewController2.pushFrontViewController(navigationController, animated: true)
                        
                        self.present(initialViewController2, animated: true)
                            
                            
                    
                        
                        //At this point, the user will be taken to the next screen
                    }else{
                        self.showToast(message: "Please email-verify your account first")
                        
                    }
                    
                }
            }
            
        }
        else{
            
            showToast(message: "You left email/password empty")
        }
        
        
    }
    @IBAction func loginaction(_ sender: UIButton) {
        
        
        
      
        
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
  
    override func viewWillAppear(_ animated: Bool) {
       handle =  Auth.auth().addStateDidChangeListener { (auth, user) in
        
       

            if Auth.auth().currentUser != nil {
                
                 if((Auth.auth().currentUser?.isEmailVerified)!){
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "reveal") as! SWRevealViewController
                var initialViewController3 = UIViewController()
                
                
                if(self.pushnotification){
                    initialViewController3 = storyboard.instantiateViewController(withIdentifier: "notification") as! notification
                }
                    
                else{
                    
                    initialViewController3 = storyboard.instantiateViewController(withIdentifier: "searchemployee") as! searchcontroller
                    
                }
                let navigationController:UINavigationController = UINavigationController(rootViewController: initialViewController3)
                
                initialViewController2.pushFrontViewController(navigationController, animated: true)
                
                self.present(initialViewController2, animated: true)
                
                
            }else {
                
                    self.showToast(message: "Please email-verify your account first")
            }
        
        }
        
        else{
            
             
        }
          
        }
       
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    @IBOutlet weak var emailreset: UITextField!
    
    @IBAction func clickrestbutton(_ sender: Any) {
        
        self.view.addSubview(popoverreset)
        popoverreset.layer.cornerRadius = 10
        popoverreset.center = passwordtext.center
        
    }
    @IBAction func sentresetaction(_ sender: Any) {
        let emailtoreset = emailreset.text
        
        if(!(emailtoreset?.isEmpty)!){
            Auth.auth().sendPasswordReset(withEmail: emailtoreset!) { error in
                // Your code here
                if(error != nil){
                 
                     self.showToast(message: error.debugDescription)
                    
                }else{
                    
                    
                       self.showToast(message: "Reset password email has been sent")
                    self.popoverreset.removeFromSuperview()
                }
            }
            
            
            
        }
        else{
            
            showToast(message: "Pls Enter your email address")
        }
    }
    
    @IBAction func closedpopreset(_ sender: Any) {
        
         self.popoverreset.removeFromSuperview()
    }
    
    
}
extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-150, width: 200, height: 100))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}
