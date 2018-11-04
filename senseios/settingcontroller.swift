//
//  settingcontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 03/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class settingcontroller: UIViewController {

    @IBOutlet weak var menubutton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
    }
    

 
}
