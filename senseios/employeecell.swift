//
//  employeecell.swift
//  senseios
//
//  Created by Hasanul Isyraf on 31/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class employeecell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var averagerating: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var staffid: UILabel!
    
    @IBOutlet weak var numberofraters: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
