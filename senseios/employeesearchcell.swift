//
//  employeesearchcell.swift
//  senseios
//
//  Created by Hasanul Isyraf on 05/01/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class employeesearchcell: UITableViewCell {
    
    
    @IBOutlet weak var rateUser: UIButton!
    @IBOutlet weak var imageprofile: UIImageView!
    
    @IBOutlet weak var totalraters: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var staffid: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var showRewardBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
