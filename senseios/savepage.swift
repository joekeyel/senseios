//
//  savepage.swift
//  senseios
//
//  Created by Hasanul Isyraf on 04/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase


class savepage: UIViewController,UITextViewDelegate {
    
    
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var bottomconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonsave: UIButton!
 
    @IBOutlet var popoversuccess: UIView!
    @IBOutlet weak var ratingremark: UITextView!
    @IBOutlet weak var smileyimage: UIImageView!
    
    @IBOutlet weak var okbutton: UIButton!
    
    
    var rating:String = ""
    var employeeinfo:employeemodel = employeemodel()
    let blureffect = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingremark.delegate = self
      
        ratingremark.isUserInteractionEnabled = true
        ratingremark.text = "Please Double tab to enter remark for your rating"
         ratingremark.textColor = UIColor.lightGray

        buttonsave.layer.cornerRadius = 10
            
        smileyimage.image = UIImage(named:rating)
        let myColor = UIColor.black
        ratingremark.layer.borderColor = myColor.cgColor
        ratingremark.layer.borderWidth = 1.0
        
        ratingremark.layer.cornerRadius = 5
        
        setdesc(rating: rating)
       
        
        
       
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tabtextfield(_:)))
        ratingremark.addGestureRecognizer(tapGesture)
        
        
        blureffect.backgroundColor = UIColor(white: 1, alpha: 0.8)
        blureffect.frame = view.bounds
        
        popover.setCellShadow()
        popoversuccess.setCellShadow()
        
        
      
        
        
    }
    
    
    func setdesc(rating:String){
        
        if(rating == "1" || rating == "2" || rating == "3" || rating == "4" || rating == "4" || rating == "5" || rating == "6"){
            
            desc.text = "I am sorry to disappoint you. I would love to know how can I improve on what I am doing?"
        }
        
        
        if(rating == "7" || rating == "8" ){
            
            desc.text = "Thanks for taking the time to share your feedback with me. If I could do just one thing to make you extremely satisfied, what would it be?"
        }
        
        
        if(rating == "9" || rating == "10" ){
            
            desc.text = "Awesome, thanks for your feedback! Would you tell me why you feel that way?"
        }
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

   
    
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//                self.view.frame.origin.y += ratingremark.frame.origin.y/2
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
    
    @objc func tabtextfield(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBOutlet var popover: UIView!
    
    @IBAction func confirmaction(_ sender: Any) {
        
      okbutton.isEnabled = false
        
        let ratingremarkstr = ratingremark.text
        
         updaterating(employeename: employeeinfo.name!, division: employeeinfo.division!, staffid: employeeinfo.staffid!, email: employeeinfo.email!, uid: employeeinfo.uid!, activity: employeeinfo.activity!, activityremark: employeeinfo.activityremark!, rating: employeeinfo.rating!, ratingremark: ratingremarkstr!, updatedby: (Auth.auth().currentUser?.email)!)
    }
    
    
    @IBAction func cancelaction(_ sender: Any) {
        
        popover.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    @IBAction func saveaction(_ sender: Any) {
        
         buttonsave.isEnabled = false
         self.view.endEditing(true)
        
        let ratingremarkstr = ratingremark.text
//
//        ratingremark.text = "\(employeeinfo.name) \(employeeinfo.email) \(employeeinfo.staffid) \(employeeinfo.uid) \(employeeinfo.rating)"
//
       
        if((ratingremarkstr?.elementsEqual("Please Double tab to enter remark for your rating"))!){
            
             showToast(message: "Pls Insert a remark")
            
        }
        
        else if((ratingremarkstr?.isEmpty)!){
            
            showToast(message: "Pls Insert a remark")
            
        }else{
            
            self.view.addSubview(blureffect)
            self.view.addSubview(popover)
          
            popover.center = view.center
            
            
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
                        
                        
                      
                        
                        if(result.elementsEqual("Rating Sucessfully Submitted")){
                            
                         
                            self.view.addSubview(self.blureffect)
                            self.view.addSubview(self.popoversuccess)
                            self.popoversuccess.center = self.view.center
                            
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
    
    
    @IBAction func gotosearchpage(_ sender: Any) {
        
        self.revealViewController()?.rearViewController.performSegue(withIdentifier: "Search", sender: self.revealViewController()?.rearViewController)
        
            popoversuccess.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if ratingremark.textColor == UIColor.lightGray {
            ratingremark.text = nil
            ratingremark.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if ratingremark.text.isEmpty {
            ratingremark.text = "Please Double tab to enter remark for your rating"
            ratingremark.textColor = UIColor.lightGray
        }
    }
   
}
