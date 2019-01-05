//
//  qrgeneratorimage.swift
//  senseios
//
//  Created by Hasanul Isyraf on 05/01/2019.
//  Copyright © 2019 Hasanul Isyraf. All rights reserved.
//

import UIKit
import Firebase

class qrgeneratorimage: UIViewController {
    
    
    @IBOutlet weak var qrimage: UIImageView!
    var activity = ""
    var activityremark = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let image = generateQRCode(from: "\((Auth.auth().currentUser?.email)!),\(activity),\(activityremark)")
        
        qrimage.image = image
       
    }
    
    
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
   

}