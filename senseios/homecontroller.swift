//
//  homecontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 27/09/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit

class homecontroller: UIViewController {
    
    
    

    @IBOutlet weak var getstarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       

        getstarted.layer.cornerRadius = 10
      
     
        let imagebg:UIImage = UIImage(named:"background")!
        let imagebgresize = resizeToScreenSize(image: imagebg)
        
       
        self.view.backgroundColor = UIColor(patternImage:imagebgresize )
        
        //add badge to bar item
        
      
      
        
    }
    @objc func rightButtonTouched() {
        print("right button touched")
    }
    

    @IBAction func gotosearch(_ sender: Any) {
         self.revealViewController()?.rearViewController.performSegue(withIdentifier: "Search", sender: self.revealViewController()?.rearViewController)
        
    }
    
    func resizeToScreenSize(image: UIImage)->UIImage{
        
        let screenSize = self.view.bounds.size
        
        
        return resizeImage(image: image, newWidth: screenSize.width)
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}


extension CAShapeLayer {
    public func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}
