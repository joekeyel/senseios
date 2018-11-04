//
//  mapscontroller.swift
//  boilerplate
//
//  Created by Hasanul Isyraf on 08/10/2018.
//  Copyright © 2018 Hasanul Isyraf. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class mapscontroller: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var menubutton: UIBarButtonItem!
    
    
    @IBOutlet weak var mapview: GMSMapView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menubutton.target = self.revealViewController()
        menubutton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        
        
        mapview.isMyLocationEnabled = true
        mapview.delegate = self
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations.last
        
        
        let marker = GMSMarker(position: (location?.coordinate)!)
        marker.title = "My Location"
         marker.icon = UIImage(named:"mylocation")
        marker.map = mapview
       
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
        mapview.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }

  
    
}
