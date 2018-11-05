//
//  feedscontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 03/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase
import moa



class feedscontroller: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var searchbar: UISearchBar!
    
   
    
    @IBOutlet weak var employeetable: UITableView!
    
    var listemployee:[employeemodel]? = []
    let rows = ["satu","dua","tiga"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listemployee!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "employeecell", for: indexPath) as! employeecell
        
        
        cell.name.text = listemployee![indexPath.row].name
        cell.staffid.text = listemployee![indexPath.row].staffid
        cell.division.text = listemployee![indexPath.row].division
           cell.email.text = listemployee![indexPath.row].email
        fetchrating(email: listemployee![indexPath.row].email!,cellrating:cell.averagerating,cellcount: cell.numberofraters)
        
        
        
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to download
       
      
        
        let imageviewe =  cell.imageprofile
        
        imageviewe?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        imageviewe?.contentMode = UIViewContentMode.scaleAspectFit
        
        
        let islandRef = storageRef.child("senseprofile/"+(listemployee![indexPath.row].uid)!+".jpg")
        
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
                
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                
                imageviewe?.image = image
            }
        }
        
        //using firebase UI to view image directly from firebase referrence ui
         // imageviewe?.sd_setImage(with: islandRef)
        

        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let useremail = Auth.auth().currentUser?.email
        let clickemail = listemployee![indexPath.row].email
        
        if((useremail?.elementsEqual(clickemail!))!){
            
            showToast(message: "U cannot rate your self")
        }else{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectactivity") as! selectactivitycontroller
        
        
        initialViewController2.employeeinfo = listemployee![indexPath.row]
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
            
        }
    }
    
    
    

    @IBOutlet weak var menubutton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        
        
        
        //setup for navigation
        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        
    }
    
    @IBAction func searchaction(_ sender: Any) {
        let query = searchbar.text
        
      self.view.endEditing(true)
        fetchsummary(query: query!)
       
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
//                        self.activitiyindicator.stopAnimating()
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
                       
                      
                     
                        
                        cellrating.text = rating
                        cellcount.text = numberofraters
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


    
    //this is when user tap to dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
