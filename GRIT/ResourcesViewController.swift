//
//  ResourcesViewController.swift
//  GRIT
//
//  Created by Jake Alvord on 4/30/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResourcesViewController: UIViewController, ModalViewControllerDelegate {
    
    let subview = UIView()
    let map_view = UIView()
    let map = MKMapView()
    let locationManager = CLLocationManager()
    //let temp_ann = MKAnnotationView()
    let modalView = ModalViewController()
    let filter = UIButton()
    
    let locale = CLLocationCoordinate2DMake(39.9612, -82.9988)

    override func viewDidLoad() {
        super.viewDidLoad()
        //request_location_access(location_manager: locationManager, map: map)
        requestLocationAccess()

        // ------------------------------------------------------------------------------------
        // map additions
        // ------------------------------------------------------------------------------------
        
        map.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.bounds.height)
        map.showsUserLocation = true
        
        map_view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        map_view.addSubview(map)
        
        let tab_height = tabBarController?.tabBar.frame.size.height
        
        filter.frame = CGRect(x: tab_height!/4, y: self.view.frame.height - 75 - tab_height! - tab_height!/4, width: 75, height: 75)
        filter.setTitle("Filter", for: .normal)
        filter.setTitleColor(UIColor.white, for: .normal)
        filter.layer.cornerRadius = filter.frame.width/2
        filter.layer.masksToBounds = true
        filter.backgroundColor = UIColor.lightGray
        filter.showsTouchWhenHighlighted = true
        filter.addTarget(self, action: #selector(button_tapped), for: .touchDown)
        
        //let filter_view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        //filter_view.addSubview(filter)
        
        self.view.addSubview(map)
        self.view.addSubview(filter)
        
        self.modalView.delegate = self
        
    }
    
    func showModal() {
        self.map.removeAnnotations(self.map.annotations)
        modalView.modalPresentationStyle = .overCurrentContext
        self.present(self.modalView, animated: true, completion: nil)
    }
    
    func resetButton() {
        if filter.isHidden == true {
            filter.isHidden = false
        }
    }
    
    func dismiss(modalText: Array<String>) {
        //print(modalText)
        self.modalView.dismiss(animated: true, completion: nil)
        resetButton()
        populate(modalText: modalText)
    }
    
    func populate(modalText: Array<String>) {

        FirebaseManager.sharedInstance.getBusinesses(flags: modalText) {
            businesses in
        
            for business in businesses {

                if (modalText.contains(business.category)) {
                
                    let geoCoder = CLGeocoder()
            
                    let street = business.street + ", "
                    let city = business.city + ", "
                    let state = business.state + ", "
                    let zip = business.zip
                    var newZip = ""
                    if zip != nil {
                        newZip = String(zip!)
                    }
            
                    let address : String! = street + city + state + newZip
            
                    geoCoder.geocodeAddressString(address) { (placemarks, error) in
                        guard
                            let placemarks = placemarks,
                            let locat = placemarks.first?.location
                            else {
                                // handle no location found
                                return
                            }
            
                        let temp_ann = MKAnnotationView()
                        let pin = MKPointAnnotation()
                        pin.coordinate = locat.coordinate
                        pin.title = business.name
                        pin.subtitle = business.category
                        temp_ann.annotation = pin
            
                        self.map.addAnnotation(temp_ann.annotation!)
                    
                    }
                    
                }
            }
        }
        
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                map.userTrackingMode = .follow
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: (locationManager.location?.coordinate)!, span: span)
                map.setRegion(region, animated: true)
                break
            
            case .denied, .restricted:
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: locale, span: span)
                map.setRegion(region, animated: true)
                break
            
            default:
                locationManager.requestWhenInUseAuthorization()
                
                
                break
        }
    }
    
    @IBAction func button_tapped() {
        
        if filter.isHidden == false {
            filter.isHidden = true
            showModal()
        }

    }

    
}
