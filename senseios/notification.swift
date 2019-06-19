//
//  notification.swift
//  senseios
//
//  Created by Hasanul Isyraf on 19/06/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class notification: UIViewController {
    
    
    @IBOutlet weak var menubutton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
    }
    

    
}
