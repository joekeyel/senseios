//
//  SelectRater.swift
//  senseios
//
//  Created by Hasanul Isyraf on 19/06/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class SelectRater: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
//    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var searchbtn: UIButton!
    @IBOutlet weak var searchbar: UISearchBar!
    let employeeobject = employeemodel()
     var listemployee:[employeemodel]? = []
    
    @IBOutlet weak var employeetable: UITableView!
    var regid:String = "";
    var userposition = "";
    

    
    
    var activity:String = ""
    var activityremark:String = ""
    var email:String = (Auth.auth().currentUser?.email)!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
  
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listemployee!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell2 = Bundle.main.loadNibNamed("employeesearchcellrater", owner: self, options: nil)?.first as! employeesearchcellrater
        
        cell2.name.text = listemployee![indexPath.row].name
        
        
        cell2.staffid.text = listemployee![indexPath.row].staffid
        
        
        cell2.division.text = "Division:\(listemployee![indexPath.row].division ?? "")"
        
        cell2.email.text = listemployee![indexPath.row].email
        
        cell2.notify.tag = indexPath.row
        cell2.notify.addTarget(self, action: #selector(NotifiyUserRequest), for: .touchUpInside)
        
        
        cell2.statusnotify.setImage(UIImage(named:"notification"), for: .normal)
        cell2.statusnotify.isHidden = true
      
        
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
    
    
    
    @IBAction func searchaction(_ sender: Any) {
        
        let query = searchbar.text
        
        self.view.endEditing(true)
        if(!(query?.isEmpty)!){
            fetchsummary(query: query!)
        }
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
                                let email = summaryfromjson["email"] as? String, let staffid = summaryfromjson["staffid"], let division = summaryfromjson["division"], let uid = summaryfromjson["uid"], let regid = summaryfromjson["regid"],let position = summaryfromjson["position"]{
                                
                                
                                
                                employeeobject.name = employeename
                                employeeobject.division = division as? String
                                employeeobject.staffid = staffid as? String
                                employeeobject.uid = uid as? String
                                employeeobject.email = email
                                employeeobject.regid = regid as? String
                                
                                if(email == Auth.auth().currentUser?.email){
                                    employeeobject.position = position as? String
                                    self.userposition = position as? String ?? ""
                                }
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
    
    
    
    @objc func NotifiyUserRequest(sender: UIButton!) {
        
        
        let objectEmployee = listemployee![sender.tag]
        
        let useremail = Auth.auth().currentUser?.email
        let clickemail = objectEmployee.email
        
        if((useremail?.elementsEqual(clickemail!))!){
            
            showToast(message: "U cannot Notify yourself")
        }else{
            
            sender.isHidden = true
            
            requestNotificationApi(emailrequestor: email, email: clickemail!, activity: activity, activityremark: activityremark,buttonview: sender)
            
        }
        
    }
    
    func requestNotificationApi(emailrequestor:String,email:String,activity:String,activityremark:String,buttonview:UIButton){
        
        let parameters = ["email" : email,
                          "emailrequestor": emailrequestor,
                          "activity":activity,
                          "activityremark":activityremark,
                         ].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/send_notification.php")! as URL)
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
            var result:Int = 0
            if let data = data {
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    
                    result = json["success"] as! Int
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        
                        if(result == 1){
                            
                            buttonview.isHidden = false
                            buttonview.setImage(UIImage(named:"notification"), for: .normal)
                            buttonview.setTitle("", for: .normal)
                            buttonview.isEnabled = false
                            
                            
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
