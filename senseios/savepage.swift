//
//  savepage.swift
//  senseios
//
//  Created by Hasanul Isyraf on 04/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class savepage: UIViewController {
    
    @IBOutlet weak var bottomconstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonsave: UIButton!
 
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
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tabtextfield(_:)))
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
    
    func tabtextfield(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @IBAction func saveaction(_ sender: Any) {
        
        let ratingremarkstr = ratingremark.text
//
//        ratingremark.text = "\(employeeinfo.name) \(employeeinfo.email) \(employeeinfo.staffid) \(employeeinfo.uid) \(employeeinfo.rating)"
//
        if(!(ratingremarkstr?.isEmpty)!){

            updaterating(employeename: employeeinfo.name!, division: employeeinfo.division!, staffid: employeeinfo.staffid!, email: employeeinfo.email!, uid: employeeinfo.uid!, activity: employeeinfo.activity!, activityremark: employeeinfo.activityremark!, rating: employeeinfo.rating!, ratingremark: ratingremarkstr!, updatedby: (Auth.auth().currentUser?.email)!)


        }
        
        else{
            
            showToast(message: "Pls Insert a remark")
            
        }
        
    }
    
    
    
  //updaterating( String employeename,String division,String staffid,String email,String uid,String activity,String activityremark,String rating,String ratingremark,String updatedby)
    func updaterating(employeename:String,division:String,staffid:String,email:String,uid:String,activity:String,activityremark:String,rating:String,ratingremark:String,updatedby:String){
        
        let parameters = ["employeename" : employeename,
                          "division": division,
                          "staffid":staffid,
                          "email":email,
                          "uid":uid,
                          "activity":activity,
                          "activityremark":activityremark,
                          "rating":rating,
                          "ratingremark":ratingremark,
                          "updatedby":updatedby].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/insertuserrating.php")! as URL)
        request.httpMethod = "POST"
        let postString = parameters.joined(separator: "&")
        
        
        print(postString)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
    
        
        //execute the request
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                
                
                return
            }
            
            
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
                
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            var result:String = ""
            if let data = data {
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    
                    result = json["result"] as! String
                    
                    
                    DispatchQueue.main.async {
                        
                        if(result == "Rating Sucessfully Submitted"){
                            
                            self.showToast(message: "Sucess")
                            
                            self.revealViewController()?.rearViewController.performSegue(withIdentifier: "Search", sender: self.revealViewController()?.rearViewController)
                        }else{
                            
                            self.showToast(message: "Failed")
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
            
            
           
            
            print("responseString = \(String(describing: responseString))")
        }
        
        task.resume()
        
        
    }
    
   
}
