//
//  profilecell.swift
//  senseios
//
//  Created by Hasanul Isyraf on 21/05/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class profilecell: UITableViewCell {
    
    
    @IBOutlet weak var imageprofile: UIImageView!
    
    @IBOutlet weak var employeename: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var staffid: UILabel!
    
    @IBOutlet weak var raters: UILabel!
    
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var division: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
