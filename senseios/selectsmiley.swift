//
//  selectsmiley.swift
//  senseios
//
//  Created by Hasanul Isyraf on 04/11/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class selectsmiley: UIViewController {
    
    @IBOutlet weak var noticemsg: UILabel!
    @IBOutlet var noticepopover: UIView!
    
    var employeeinfo:employeemodel = employeemodel()
    
   let blureffect = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        blureffect.backgroundColor = UIColor(white: 1, alpha: 0.8)
        blureffect.frame = view.bounds
        noticepopover.center = view.center
        noticepopover.setCellShadow()
       
        view.addSubview(blureffect)
        view.addSubview(noticepopover)
        
        let question = "Welcome \( Auth.auth().currentUser!.email ?? "") to \( employeeinfo.name ?? "") Survey Portal!\n Are you happy to work with me in the last engagement?\nPlease rate from 0 (Extremely Difficult) to 10 (Extremely Easy)\n Activity:\(employeeinfo.activity ?? "")\nDescription:\(employeeinfo.activityremark ?? "")"
        
       noticemsg.text = question
        
    }
    
    
    @IBAction func showpopover(_ sender: Any) {
        view.addSubview(blureffect)
        view.addSubview(noticepopover)
    }
    
    @IBAction func closenotice(_ sender: Any) {
        noticepopover.removeFromSuperview()
        blureffect.removeFromSuperview()
    }
    

    @IBAction func select1action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "10"
        employeeinfo.rating = "10"
        
          initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
        
    }
    
    
    @IBAction func select2action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "9"
        employeeinfo.rating = "9"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select3action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "8"
        
        employeeinfo.rating = "8"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    
    @IBAction func select4action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "7"
        
        employeeinfo.rating = "7"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select5action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "6"
        
        employeeinfo.rating = "6"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select6action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "5"
        
        employeeinfo.rating = "5"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    
    @IBAction func select7action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "4"
        
        employeeinfo.rating = "4"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select8action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "3"
        
        employeeinfo.rating = "3"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select9action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "2"
        
        employeeinfo.rating = "2"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
    @IBAction func select10action(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController2 = storyboard.instantiateViewController(withIdentifier: "savepage") as! savepage
        
        
        initialViewController2.rating = "1"
        
        employeeinfo.rating = "1"
        
        initialViewController2.employeeinfo = employeeinfo
        
        self.navigationController?.pushViewController(initialViewController2, animated: true)
    }
    
}
