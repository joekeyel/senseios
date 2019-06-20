//
//  notification.swift
//  senseios
//
//  Created by Hasanul Isyraf on 19/06/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class notification: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
     var notificationlist:[notificationmodel]? = []
    
    @IBOutlet weak var menubutton: UIBarButtonItem!
    
    @IBOutlet weak var notificationtable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        fetchsummary(query: (Auth.auth().currentUser?.email!)!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notificationlist!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = Bundle.main.loadNibNamed("notificationcell", owner: self, options: nil)?.first as! notificationcell
        
        cell2.msg.text = notificationlist![indexPath.row].msg
        cell2.notificationdate.text = notificationlist![indexPath.row].notificationdate
        
        
        
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "selectsmiley") as! selectsmiley
        
        let employeeobject:employeemodel = employeemodel()
        employeeobject.activity = notificationlist![indexPath.row].activity
        employeeobject.activityremark = notificationlist![indexPath.row].activityremark
        employeeobject.division = notificationlist![indexPath.row].division
          employeeobject.name = notificationlist![indexPath.row].employeename
          employeeobject.staffid = notificationlist![indexPath.row].staffid
          employeeobject.email = notificationlist![indexPath.row].sender
        employeeobject.uid = ""
        
        initialViewController2.employeeinfo = employeeobject
        
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    
    func fetchsummary(query:String){
        
        
        let parameters = ["email" : query  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/notificationlist.php")!
        
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
                
                self.notificationlist = [notificationmodel]()
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    if  let summaryfromjson  = json["notificationlist"] as? [[String:AnyObject]]{
                        
                        for summaryfromjson in summaryfromjson {
                            let employeeobject = notificationmodel()
                            if let id = summaryfromjson["idnotification"] as? String,
                                let sender = summaryfromjson["sender"] as? String, let staffid = summaryfromjson["staffid"], let division = summaryfromjson["division"], let activity = summaryfromjson["activity"], let activityremark = summaryfromjson["activityremark"],let msg = summaryfromjson["msg"],let notificationdate = summaryfromjson["notificationdate"],let employeename =  summaryfromjson["employeename"] ,let receiver = summaryfromjson["receiver"] as? String{
                                
                                
                                
                                employeeobject.employeename = employeename as? String
                                employeeobject.division = division as? String
                                employeeobject.staffid = staffid as? String
                                employeeobject.activity = activity as? String
                                employeeobject.activityremark = activityremark as? String
                                employeeobject.sender = sender
                                employeeobject.receiver = receiver
                                employeeobject.id = id
                                employeeobject.notificationdate = notificationdate as? String
                                employeeobject.msg = msg as? String
                                
                                
                              
                            }
                            self.notificationlist?.append(employeeobject)
                            
                            
                        }
                        
                    }
                    DispatchQueue.main.async {
                        self.notificationtable.reloadData()
                        
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
