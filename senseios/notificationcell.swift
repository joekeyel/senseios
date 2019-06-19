//
//  notificationcell.swift
//  senseios
//
//  Created by Hasanul Isyraf on 19/06/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class notificationcell: UITableViewCell {
    
    @IBOutlet weak var msg: UILabel!
    
    @IBOutlet weak var notificationdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
