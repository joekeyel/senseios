//
//  rewardcell.swift
//  senseios
//
//  Created by Hasanul Isyraf on 21/05/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class rewardcell: UITableViewCell {
    
    @IBOutlet weak var item: UILabel!
    
    @IBOutlet weak var point: UILabel!
    
    @IBOutlet weak var delete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
