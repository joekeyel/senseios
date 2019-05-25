//
//  feedscontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 03/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

import AVFoundation




class feedscontroller: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    @IBOutlet weak var searchbar: UISearchBar!
      let employeeobject = employeemodel()
   
    @IBOutlet weak var galleryqr: UIButton!
    @IBOutlet weak var cameraqr: UIButton!
    @IBOutlet var popover: UIView!
    
    @IBOutlet weak var employeetable: UITableView!
    
    @IBOutlet weak var searchbtn: UIButton!
   
    
    
    
    
    var listemployee:[employeemodel]? = []
    let rows = ["satu","dua","tiga"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listemployee!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell2 = Bundle.main.loadNibNamed("employeesearchcell", owner: self, options: nil)?.first as! employeesearchcell
        
        
        cell2.name.text = listemployee![indexPath.row].name
        
        
         cell2.staffid.text = listemployee![indexPath.row].staffid
        
        
        cell2.division.text = "Division:\(listemployee![indexPath.row].division ?? "")"
        
         cell2.email.text = listemployee![indexPath.row].email
        
        cell2.rateUser.tag = indexPath.row
        cell2.rateUser.addTarget(self, action: #selector(RateUserAction), for: .touchUpInside)
        
        
        cell2.showRewardBtn.tag = indexPath.row
        cell2.showRewardBtn.addTarget(self, action: #selector(ShowUserReward), for: .touchUpInside)
        
        fetchrating(email: listemployee![indexPath.row].email!,cellrating:cell2.average,cellcount: cell2.totalraters)
        
        
        
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to download
       
      
        
        let imageviewe =  cell2.imageprofile
        
        imageviewe?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        imageviewe?.contentMode = UIViewContentMode.scaleAspectFit
        
        
        let islandRef = storageRef.child("senseprofile/"+(listemployee![indexPath.row].uid)!+".jpg")
        
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
            
                print(error.localizedDescription)
                
                 let image = UIImage(named: "9")
                imageviewe?.image = image
                
            } else {
               
                let image = UIImage(data: data!)
                
                imageviewe?.image = image
            }
        }
        
    
        

        
        return cell2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    

    @IBOutlet weak var menubutton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
     
     
       
      
        
        checkuserexist(email:    (Auth.auth().currentUser?.email)!, uid:    (Auth.auth().currentUser?.uid)!)
      
        
        //setup for navigation
        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        cameraqr.layer.cornerRadius = 5
        cameraqr.layer.borderWidth = 1
        cameraqr.layer.borderColor = UIColor.black.cgColor
        
        galleryqr.layer.cornerRadius = 5
        galleryqr.layer.borderWidth = 1
        galleryqr.layer.borderColor = UIColor.black.cgColor
        
        searchbtn.layer.cornerRadius = 5
        searchbtn.layer.borderWidth = 1
        searchbtn.layer.borderColor = UIColor.black.cgColor
        
        
        fetchsummary(query:(Auth.auth().currentUser?.email)!)
        
        
    }
    
    
    @IBAction func hidepopover(_ sender: Any) {
        
        self.popover.removeFromSuperview()
    }
    
    @IBAction func searchaction(_ sender: Any) {
        let query = searchbar.text
        
      self.view.endEditing(true)
        if(!(query?.isEmpty)!){
        fetchsummary(query: query!)
        }
    }
    
    
    @objc func RateUserAction(sender: UIButton!) {
        
        
        let objectEmployee = listemployee![sender.tag]
        
        let useremail = Auth.auth().currentUser?.email
        let clickemail = objectEmployee.email
        
        if((useremail?.elementsEqual(clickemail!))!){
            
            showToast(message: "U cannot rate your self")
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectactivity") as! selectactivitycontroller
            
            
            initialViewController2.employeeinfo = objectEmployee
            
            self.navigationController?.pushViewController(initialViewController2, animated: true)
            
            //            self.navigationController!.pushViewController(selectactivity2(nibName: "selectactivity2", bundle: nil), animated: true)
            
        }
        
    }
    
    
    @objc func ShowUserReward(sender: UIButton!) {
        
        
        let objectEmployee = listemployee![sender.tag]


            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "RewardActivity") as! RewardActivityController


            initialViewController2.employeeobject = objectEmployee

            self.navigationController?.pushViewController(initialViewController2, animated: true)

        
            
      
        
    }
    
    func fetchsummary(query:String){
        
      
        
        let parameters = ["query" : query  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/employeelist.php")!
        
        var items = [URLQueryItem]()
        
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlrequest = URLRequest(url: urlComp.url!)
        urlrequest.httpMethod = "GET"
        
        
        //execute the request
        
        let task = URLSession.shared.dataTask(with: urlrequest){(data,response,error)  in
            
            if let data = data {
                
                self.listemployee = [employeemodel]()
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    if  let summaryfromjson  = json["employeelist"] as? [[String:AnyObject]]{
                        
                        for summaryfromjson in summaryfromjson {
                            let employeeobject = employeemodel()
                            if let employeename = summaryfromjson["employeename"] as? String,
                                let email = summaryfromjson["email"] as? String, let staffid = summaryfromjson["staffid"], let division = summaryfromjson["division"], let uid = summaryfromjson["uid"], let regid = summaryfromjson["regid"]{
                                
                                
                                
                                employeeobject.name = employeename
                                employeeobject.division = division as? String
                                employeeobject.staffid = staffid as? String
                                employeeobject.uid = uid as? String
                                employeeobject.email = email
                                employeeobject.regid = regid as? String
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.listemployee?.append(employeeobject)
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        self.employeetable.reloadData()
                       
                    }
                    
                }
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
                
                
            else if let error = error {
                print(error.localizedDescription)
            }
            
            
        }
        
        task.resume()
        
    }
    
    //fetch rating for every cell appear
    
    
    func fetchrating(email:String,cellrating:UILabel,cellcount:UILabel){
        
        let parameters = ["email" : email  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/getuserrating.php")!
        
        var items = [URLQueryItem]()
        
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlrequest = URLRequest(url: urlComp.url!)
        urlrequest.httpMethod = "GET"
        
        var rating:String = "100"
        var numberofraters:String = "0"
        //execute the request
        
        let task = URLSession.shared.dataTask(with: urlrequest){(data,response,error)  in
            
            if let data = data {
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                  
                        rating = json["average"] as! String
                    numberofraters = json["numberofrater"] as! String
                  
                    DispatchQueue.main.async {
                       
                      
                        if(Auth.auth().currentUser?.email == email){
                        
                            cellrating.text = "Average:\(rating)"
                            cellcount.text = "Raters:\(numberofraters)"
                            
                        }else{
                            cellrating.isHidden = true
                            cellcount.text = "Raters:\(numberofraters)"
                        }
                    }
                    
                    
                }
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
                
                
            else if let error = error {
                print(error.localizedDescription)
            }
            
            
        }
        
        task.resume()
       
        
    }

    func checkuserexist(email:String,uid:String){
        
        let parameters = ["email":email,
                          "uid":uid,
                         ].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/updateuserid.php")! as URL)
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
                        
                     
                        if(result.elementsEqual("user not exist")){
                            self.view.addSubview(self.popover)
                            self.popover.center = self.view.center
                            self.popover.layer.cornerRadius = 10
                            self.popover.layer.shadowRadius = 5
                            
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
    
    //this is when user tap to dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var namepop: UITextField!
    
    @IBOutlet weak var divisionpop: UITextField!
    @IBOutlet weak var staffidpop: UITextField!
    
    @IBAction func insertnewuser(_ sender: Any) {
        
        let name = namepop.text
        let divison = divisionpop.text
        let staffid = staffidpop.text
        let email = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        
        if(!(name?.isEmpty)! && !(divison?.isEmpty)! && !(staffid?.isEmpty)!){
            
            insertnewuserjson(email: email!, uid: uid!, staffid: staffid!, division: divison!, employeename: name!)
            
        }
        
        else{
            
            
            showToast(message: "Pls Insert Your Details to continue")
        }
    }
    
    func insertnewuserjson(email:String,uid:String,staffid:String,division:String,employeename:String){
        
        let parameters = ["email":email,
                          "uid":uid,
                          "staffid":staffid,
                          "division":division,
                          "employeename":employeename
                          ].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/insertuser.php")! as URL)
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
                        
                        
                        if(result.elementsEqual("success")){
                           self.showToast(message: "Success")
                            self.popover.removeFromSuperview()
                            
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
    
    
    @IBAction func qrreadeimage(_ sender: Any) {
         let imagepickercontroller = UIImagePickerController()
         imagepickercontroller.delegate = self
        imagepickercontroller.sourceType = .photoLibrary
        self.present(imagepickercontroller,animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
         print(info)
        
        if let qrcodeImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let detector:CIDetector=CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
            let ciImage:CIImage=CIImage(image:qrcodeImg)!
            var qrCodeLink=""
            
            print("what the")
            
            let features=detector.features(in: ciImage)
            for feature in features as! [CIQRCodeFeature] {
                qrCodeLink += feature.messageString!
            }
            
            if qrCodeLink=="" {
                print("nothing")
            }else{
                print("message: \(qrCodeLink)")
                
                let dataqr : [String] = qrCodeLink.components(separatedBy: ",")
                
                if(dataqr.count == 3){
                employeeobject.activity = dataqr[1]
                employeeobject.activityremark = dataqr[2]
                fetchsummaryqr(query: dataqr[0])
                }else{
                    
                    self.showToast(message: "Ops Not Found")
                }
                
            }
        }
        else{
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        
        
     
       
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func fetchsummaryqr(query:String){
        
        let parameters = ["query" : query  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/employeelist.php")!
        
        var items = [URLQueryItem]()
        
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlrequest = URLRequest(url: urlComp.url!)
        urlrequest.httpMethod = "GET"
        
        
        //execute the request
        
        let task = URLSession.shared.dataTask(with: urlrequest){(data,response,error)  in
            
            if let data = data {
                
                self.listemployee = [employeemodel]()
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    if  let summaryfromjson  = json["employeelist"] as? [[String:AnyObject]]{
                        
                        for summaryfromjson in summaryfromjson {
                          
                            if let employeename = summaryfromjson["employeename"] as? String,
                                let email = summaryfromjson["email"] as? String, let staffid = summaryfromjson["staffid"], let division = summaryfromjson["division"], let uid = summaryfromjson["uid"], let regid = summaryfromjson["regid"]{
                                
                                
                                
                                self.employeeobject.name = employeename
                                self.employeeobject.division = division as? String
                                self.employeeobject.staffid = staffid as? String
                                self.employeeobject.uid = uid as? String
                                self.employeeobject.email = email
                                self.employeeobject.regid = regid as? String
                                
                                self.listemployee?.append(self.employeeobject)
                            }
                          
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        
                        if((self.listemployee?.count)!>0){
                      
                        if(Auth.auth().currentUser?.email == self.employeeobject.email){
                            
                            self.showToast(message: "You cannot rate yourself")
                            
                        }else{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectsmiley") as! selectsmiley
                            
                            
                            initialViewController2.employeeinfo = self.employeeobject
                            
                            self.navigationController?.pushViewController(initialViewController2, animated: true)
                        }
                        }else{
                            
                            self.showToast(message: "Ops Not Found")
                        }
                        
                    }
                    
                }
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
                
                
            else if let error = error {
                print(error.localizedDescription)
            }
            
            
        }
        
        task.resume()
        
    }
    
   
}

