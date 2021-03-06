//
//  RewardActivityController.swift
//  senseios
//
//  Created by Hasanul Isyraf on 21/05/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase
import iOSDropDown

class RewardActivityController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    
    @IBOutlet weak var achievementDropDown: DropDown!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var DateReward: UIDatePicker!
    
    @IBOutlet weak var deleteOkbtn: buttonAdditional!
    
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet var popovernewAchivement: UIView!
    
    @IBOutlet weak var tablereward: UITableView!
    
    @IBOutlet var popoverDelete: UIView!
    @IBOutlet weak var cancelNewItemBtn: UIButton!
    @IBOutlet weak var addnewitemBtn: UIButton!
    var employeeobject:employeemodel = employeemodel()
    var rewardlist1:[rewardmodel] = []
    var rewardlist2:[rewardmodel] = []
    var rewardlist3:[rewardmodel] = []
    var rewardlist4:[rewardmodel] = []
    var rewardlist5:[rewardmodel] = []
    
    var rewardId:String = ""
    var dateInputStr:String = ""
    var userposition = ""
    
    
    
    let blureffect = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        fetchreward(email: employeeobject.email!)
        
        blureffect.backgroundColor = UIColor(white: 1, alpha: 0.8)
        blureffect.frame = view.bounds
        
        popovernewAchivement.layer.borderWidth = 1
        popovernewAchivement.layer.borderColor = UIColor.black.cgColor
        popovernewAchivement.layer.cornerRadius = 5
        
        
            popoverDelete.layer.borderWidth = 1
        popoverDelete.layer.borderColor = UIColor.black.cgColor
        
        popoverDelete.layer.cornerRadius = 5
        achievementDropDown.optionArray = ["Achievement 1","Achievement 2","Achievement 3","Achievement 4"]
        
        //setting up for number only input for textfield
        self.numberInput.delegate = self
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let AllowCharacter = CharacterSet.decimalDigits
        let charaterSet = CharacterSet(charactersIn: string)
        return AllowCharacter.isSuperset(of: charaterSet)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 0
        if(section == 0){
            
            rows = 1
        }
        
        if(section == 1)
        {
            
            rows = rewardlist1.count
          
        }
        
        if(section == 2)
        {
            
            rows = rewardlist2.count
            
        }
        
        if(section == 3)
        {
            
            rows = rewardlist3.count
//
        }
        
        if(section == 4)
        {
            
            rows = rewardlist4.count
        }
        
        if(section == 5)
        {
            
            rows = rewardlist5.count
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell2 = UITableViewCell()
       
        let cellreward = Bundle.main.loadNibNamed("rewardcell", owner: self, options: nil)?.first as! rewardcell
        let cellprofile = Bundle.main.loadNibNamed("profilecell", owner: self, options: nil)?.first as! profilecell
        
        
        if(indexPath.section == 1){
            
            cellreward.item.text = rewardlist1[indexPath.row].item
            cellreward.point.text = rewardlist1[indexPath.row].point
            
            
            if(self.userposition == "editor"){
            cellreward.delete.indexPath = indexPath.row
            cellreward.delete.urlString = rewardlist1[indexPath.row].id
            cellreward.delete.addTarget(self, action: #selector(OpenPopOverDelete), for: .touchUpInside)
            }
            else{
                
                cellreward.delete.isHidden = true
            }
            if(rewardlist1[indexPath.row].item!.isEmpty){
                
                cellreward.iconimage.isHidden = true
            }else{
            cellreward.iconimage.image = UIImage(named:"category1")
            }
            cell2 = cellreward
            
            
        }
        
        if(indexPath.section == 2){
            
            cellreward.item.text = rewardlist2[indexPath.row].item
            cellreward.point.text = rewardlist2[indexPath.row].point
            
           rewardId = rewardlist2[indexPath.row].id!
            
            if(self.userposition == "editor"){
              cellreward.delete.urlString = rewardlist2[indexPath.row].id
            cellreward.delete.addTarget(self, action: #selector(OpenPopOverDelete), for: .touchUpInside)
            }else{
                
                cellreward.delete.isHidden = true
            }
            
            if(rewardlist2[indexPath.row].item!.isEmpty){
                
                cellreward.iconimage.isHidden = true
            }else{
             cellreward.iconimage.image = UIImage(named:"category2")
            }
            cell2 = cellreward
            
            
        }
        
        if(indexPath.section == 3){
            
            cellreward.item.text = rewardlist3[indexPath.row].item
            cellreward.point.text = rewardlist3[indexPath.row].point
            
            rewardId = rewardlist3[indexPath.row].id!
            
            if(self.userposition == "editor"){
              cellreward.delete.urlString = rewardlist3[indexPath.row].id
            cellreward.delete.addTarget(self, action: #selector(OpenPopOverDelete), for: .touchUpInside)
            }else{
                
                cellreward.delete.isHidden = true
            }
            if(rewardlist3[indexPath.row].item!.isEmpty){
                
                cellreward.iconimage.isHidden = true
            }else{
            cellreward.iconimage.image = UIImage(named:"category3")
            }
            cell2 = cellreward
            
            
        }
        
        
        if(indexPath.section == 4){
            
            cellreward.item.text = rewardlist4[indexPath.row].item
            cellreward.point.text = rewardlist4[indexPath.row].point
            
            rewardId = rewardlist4[indexPath.row].id!
            
            if(self.userposition == "editor"){
            cellreward.delete.urlString = rewardlist4[indexPath.row].id
            cellreward.delete.addTarget(self, action: #selector(OpenPopOverDelete), for: .touchUpInside)
            }else{
                 cellreward.delete.isHidden = true
                
            }
            
            
            if(rewardlist4[indexPath.row].item!.isEmpty){
                
                cellreward.iconimage.isHidden = true
            }else{
            cellreward.iconimage.image = UIImage(named:"category4")
            }
            cell2 = cellreward
            
            
        }
        
        
        if(indexPath.section == 5){
            
            cellreward.item.text = rewardlist5[indexPath.row].item
            cellreward.point.text = rewardlist5[indexPath.row].point
            
            rewardId = rewardlist5[indexPath.row].id!
            
                if(self.userposition == "editor"){
                    
              cellreward.delete.urlString = rewardlist5[indexPath.row].id
              cellreward.delete.addTarget(self, action: #selector(OpenPopOverDelete), for: .touchUpInside)
                    
            }
                else{
                    
                      cellreward.delete.isHidden = true
            }
            if(rewardlist5[indexPath.row].item == "Organizer Of the Event/Volunteers"){
                
                  cellreward.iconimage.image = UIImage(named:"category51")
            }
            
            if(rewardlist5[indexPath.row].item == "Participant of the Event"){
                
                cellreward.iconimage.image = UIImage(named:"category52")
            }
            if(rewardlist5[indexPath.row].item == "Supporters of the Event"){
                
                cellreward.iconimage.image = UIImage(named:"category53")
            }
            
            if(rewardlist5[indexPath.row].item!.isEmpty){
                
                cellreward.iconimage.isHidden = true
            }
            
            cell2 = cellreward
            
            
        }
        
        if(indexPath.section == 0){
            
            
            
            cellprofile.employeename.text = employeeobject.name
            cellprofile.staffid.text = employeeobject.staffid
            cellprofile.division.text = employeeobject.division
            cellprofile.email.text = employeeobject.email
            
            fetchrating(email: employeeobject.email!,cellrating:cellprofile.average,cellcount: cellprofile.raters)
            
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            // Create a reference to the file you want to download
            
            
            
            let imageviewe =  cellprofile.imageprofile
            
            imageviewe?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
            imageviewe?.contentMode = UIViewContentMode.scaleAspectFit
            
            
            let islandRef = storageRef.child("senseprofile/"+(employeeobject.uid)!+".jpg")
            
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
            
            cell2 = cellprofile
        }
        
        return cell2
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let cellrewardheader = Bundle.main.loadNibNamed("rewardcellheader", owner: self, options: nil)?.first as! rewardcellheader
        
         let cellProfileheader = Bundle.main.loadNibNamed("profileCellheader", owner: self, options: nil)?.first as! profileCellheader
        
        var cellheader = UITableViewCell()
        
        if(section == 0){
            cellProfileheader.title.text = "GENERAL"
            
            //fetch the total point
            fetcrewardpoint(email: employeeobject.email!, cellreward: cellProfileheader.totalpoint)
            
            cellheader = cellProfileheader
        }
        if(section > 0){
            
            cellrewardheader.title.text = "CATEGORY \(section)"
            
            
            if(self.userposition == "editor"){
            
            cellrewardheader.addItem.tag = section
            cellrewardheader.addItem.addTarget(self, action: #selector(OpenPopOverAchievement), for: .touchUpInside)
            
            }else{
                
               cellrewardheader.addItem.isHidden = true
            }
            
            cellheader = cellrewardheader
            
        }
        return cellheader
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowheight = 0
        
        if(indexPath.section == 0){
            
            rowheight = 250
        }
        
        if(indexPath.section > 0){
            
            rowheight = 110
        }
        
        return CGFloat(rowheight)
    }
    
    
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
        
        var rating:String = ""
        var numberofraters:String = ""
    
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
    
    
    func fetcrewardpoint(email:String,cellreward:UILabel){
        
        let parameters = ["email" : email  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/gettotalreward.php")!
        
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
        
        var reward:String = ""
       
        
        //execute the request
        
        let task = URLSession.shared.dataTask(with: urlrequest){(data,response,error)  in
            
            if let data = data {
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    
                    reward = json["reward"] as! String
                  
                    
                    DispatchQueue.main.async {
                        
                        
                       
                            cellreward.text = "Point:\(reward)"
                         
                      
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
    
    func fetchreward(email:String){
        
        
        let parameters = ["email" : email  ]
        
        let urlComp = NSURLComponents(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/employeereward.php")!
        
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
                
                
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    
                    if  let summaryfromjson1  = json["category1"] as? [[String:AnyObject]]{
                         self.rewardlist1 = []
                        for summaryfromjson in summaryfromjson1 {
                            let rewardobject = rewardmodel()
                            if let item = summaryfromjson["item"] as? String,
                                let point = summaryfromjson["points"] as? String, let id = summaryfromjson["idemployeeReward"] as? String{
                                
                                
                                rewardobject.item = item
                                rewardobject.point = point
                                rewardobject.id = id
                                
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.rewardlist1.append(rewardobject)
                            
                            
                        }
                        
                    }
                    
                    if  let summaryfromjson2  = json["category2"] as? [[String:AnyObject]]{
                         self.rewardlist2 = []
                        for summaryfromjson in summaryfromjson2 {
                            let rewardobject = rewardmodel()
                            if let item = summaryfromjson["item"] as? String,
                                let point = summaryfromjson["points"] as? String, let id = summaryfromjson["idemployeeReward"] as? String{
                                
                                
                                rewardobject.item = item
                                rewardobject.point = point as? String
                                rewardobject.id = id
                                
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.rewardlist2.append(rewardobject)
                            
                            
                        }
                        
                    }
                    
                    
                    if  let summaryfromjson3  = json["category3"] as? [[String:AnyObject]]{
                         self.rewardlist3 = []
                        for summaryfromjson in summaryfromjson3 {
                            let rewardobject = rewardmodel()
                            if let item = summaryfromjson["item"] as? String,
                                let point = summaryfromjson["points"] as? String, let id = summaryfromjson["idemployeeReward"] as? String{
                                
                                
                                rewardobject.item = item
                                rewardobject.point = point as? String
                                rewardobject.id = id
                                
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.rewardlist3.append(rewardobject)
                            
                            
                        }
                        
                    }
                    
                    
                    if  let summaryfromjson4  = json["category4"] as? [[String:AnyObject]]{
                        
                        self.rewardlist4 = []
                        
                        for summaryfromjson in summaryfromjson4 {
                            let rewardobject = rewardmodel()
                            if let item = summaryfromjson["item"] as? String,
                                let point = summaryfromjson["points"] as? String, let id = summaryfromjson["idemployeeReward"] as? String{
                                
                                
                                rewardobject.item = item
                                rewardobject.point = point as? String
                                rewardobject.id = id
                                
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.rewardlist4.append(rewardobject)
                            
                            
                        }
                        
                    }
                    
                    if  let summaryfromjson5  = json["category5"] as? [[String:AnyObject]]{
                         self.rewardlist5 = []
                        for summaryfromjson in summaryfromjson5 {
                            let rewardobject = rewardmodel()
                            if let item = summaryfromjson["item"] as? String,
                                let point = summaryfromjson["points"] as? String, let id = summaryfromjson["idemployeeReward"] as? String{
                                
                                
                                rewardobject.item = item
                                rewardobject.point = point as? String
                                rewardobject.id = id
                                
                                
                                // print(listttobjects.cabinetid!)
                            }
                            self.rewardlist5.append(rewardobject)
                            
                            
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tablereward.reloadData()
                        
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
    
    
    @objc func OpenPopOverAchievement(sender: UIButton!) {
        
        if(sender.tag == 1){
            
            achievementDropDown.text = ""
            achievementDropDown.optionArray = ["Zero Medical Certificate"]
        }
        
        if(sender.tag == 2){
            
            achievementDropDown.text = ""
            achievementDropDown.optionArray = ["High Performer Per Division (9-10)","Moderate per Division (7-8)"]
        }
        
        if(sender.tag == 3){
            
            achievementDropDown.text = ""
            achievementDropDown.optionArray = ["360 > 4 TM Award (GLT,GCEO,CIIC,NPC)"]
        }
        
        if(sender.tag == 4){
            
            achievementDropDown.text = ""
            achievementDropDown.optionArray = ["Per 1s Sort,Set in Order, Shine, Standardize,Sustain"]
        }
        
        if(sender.tag == 5){
            
            achievementDropDown.text = ""
            
            achievementDropDown.optionArray = ["Organizer Of the Event/Volunteers","Participant of the Event","Supporters of the Event"]
        }
        
        addnewitemBtn.isEnabled = true
        print(sender.tag)
        addnewitemBtn.tag = sender.tag
        
        popovernewAchivement.center = view.center
        
       
        
        self.view.addSubview(blureffect)
        self.view.addSubview(popovernewAchivement)
        self.popovernewAchivement.addSubview(achievementDropDown)
        self.popovernewAchivement.addSubview(DateReward)
        DateReward.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
      
    }
    
    
    @objc func OpenPopOverDelete(sender: buttonAdditional!) {
        
     
        print(sender.urlString!)
    
        
        popoverDelete.center = view.center
        deleteOkbtn.urlString = sender.urlString
        
       // deleteReward(id: sender.urlString!,email: (Auth.auth().currentUser?.email)!)
        
        
       self.view.addSubview(blureffect)
        self.view.addSubview(popoverDelete)
        
        
    }
    
    
    @IBAction func deleteActionBtn(_ sender: Any) {
        
        deleteReward(id: self.deleteOkbtn.urlString!,email: (Auth.auth().currentUser?.email)!)
       
    }
    
    
    
    @IBAction func closedPopOver(_ sender: Any) {
        
        popovernewAchivement.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    
    @IBAction func cancelPopOver(_ sender: Any) {
        
        popovernewAchivement.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    
    
    @IBAction func cancelPopover2(_ sender: Any) {
        
        popoverDelete.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    
    
    @IBAction func InsertNewItemBtn(_ sender: Any) {
        
        addnewitemBtn.isEnabled = false
        
        print(addnewitemBtn.tag)
        
        var category:String = ""
        var achievement:String = ""
        var point:String = ""
        
         category = "category \(addnewitemBtn.tag)"
         achievement = achievementDropDown.text!
         point = numberInput.text!
        
        let employeename:String = employeeobject.name!
        let email:String = employeeobject.email!
        let updatedby:String = (Auth.auth().currentUser?.email)!
        
        
        
        
        if(!achievement.isEmpty && !point.isEmpty && !dateInputStr.isEmpty){
            
           insertNewReward(employeename: employeename, category: category, point: point, email: email, achievement: achievement, updatedby: updatedby,month: dateInputStr)
            
        }
        
        else{
            
            showToast(message: "Please Insert all Field")
            addnewitemBtn.isEnabled = true
        }
    }
    
    @objc func datePickerValueChanged (datePicker: UIDatePicker) {
        
        let dateformatter = DateFormatter()
        
       
        dateformatter.dateFormat = "YYYY-MM-dd"
        let strDate = dateformatter.string(from: NSDate() as Date) // You can pass your date here as a parameter to get in a desired format
      
       
        
        dateLabel.text = strDate
        dateInputStr = strDate
        
    }
    
    func insertNewReward(employeename:String,category:String,point:String,email:String,achievement:String,updatedby:String,month:String){
        
        
        let parameters = ["employeename" : employeename,
                          "email":email,
                          "category":category,
                          "achievement":achievement,
                          "points":point,
                          "updatedby":updatedby,
                           "month":month].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/insertuserReward.php")! as URL)
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
                        
                        self.addnewitemBtn.isEnabled = true
                        
                        
                        if(result.elementsEqual("Rating Sucessfully Submitted")){
                            
                            
                            self.popovernewAchivement.removeFromSuperview()
                            self.blureffect.removeFromSuperview()
                           
                            self.fetchreward(email: email)
                            
                          
                            
                            
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
    
    
    func deleteReward(id:String,email:String){
        
        
        let parameters = ["id" : id,
                          "email":email,
                         ].map { "\($0)=\(String(describing: $1 ))" }
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://58.27.84.166/mcconline/MCC%20Online%20V3/sense/deleteuserReward.php")! as URL)
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
                        
                        self.popoverDelete.removeFromSuperview()
                        self.blureffect.removeFromSuperview()
                        
                        self.fetchreward(email: self.employeeobject.email!)
                    
                          if(result.elementsEqual("Rating Sucessfully Submitted")){
                            
                            
                            self.showToast(message: "Sucess")
                            
                            
                        
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
