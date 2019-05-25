//
//  rewardcellheader.swift
//  senseios
//
//  Created by Hasanul Isyraf on 21/05/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit

class rewardcellheader: UITableViewCell {

    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var totalpoint: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
