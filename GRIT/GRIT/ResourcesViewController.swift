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

class ResourcesViewController: UIViewController, ModalViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let subview = UIView()
    let map_view = UIView()
    let map = MKMapView()
    let modal_view = ModalViewController()
    var location_manager : CLLocationManager!
    let temp_ann = MKAnnotationView()
    let filter = UIButton()
    let button = UIButton()
    var selected_annotation: MKPointAnnotation?
    
    let locale = CLLocationCoordinate2DMake(39.9612, -82.9988)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // requests location
        location_manager = CLLocationManager()
        location_manager.delegate = self
        
        // sets map delegate to self
        self.map.delegate = self
        
        // sets modal_view delegate to self
        self.modal_view.delegate = self
        
        // gets height of tab
        let tab_height = (tabBarController?.tabBar.frame.size.height)!

        // sets map shows users location (if possible)
        map.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.bounds.height)
        map.showsUserLocation = true

        // sets up filter button
        filter.frame = CGRect(x: tab_height/4, y: self.view.frame.height - 75 - tab_height - tab_height/4, width: 75, height: 75)
        filter.setTitle("Filter", for: .normal)
        filter.setTitleColor(UIColor.white, for: .normal)
        filter.layer.cornerRadius = filter.frame.width/2
        filter.layer.masksToBounds = true
        filter.backgroundColor = UIColor.lightGray
        filter.addTarget(self, action: #selector(button_tapped), for: .touchDown)
        
        button.frame = CGRect(x: self.view.bounds.width - 120 - tab_height/4, y: self.view.frame.height - 75 - tab_height - tab_height/4, width: 120, height: 75)
        button.setTitle("Directions", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = button.frame.width/8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(callout_tapped), for: .touchDown)
        button.isHidden = true

        // add
        self.view.addSubview(map)
        self.view.addSubview(filter)
        self.view.addSubview(button)

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            
//            manager.startUpdatingLocation()
//            map.userTrackingMode = .follow
//            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//            let region = MKCoordinateRegion(center: (manager.location?.coordinate)!, span: span)
//            map.setRegion(region, animated: true)
            break
            
        case .denied, .restricted:
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: locale, span: span)
            map.setRegion(region, animated: true)
            break
            
        default:
            manager.requestWhenInUseAuthorization()
            break
        }
        
    }
    
    func showModal() {
        modal_view.modalPresentationStyle = .overCurrentContext
        self.present(self.modal_view, animated: true, completion: nil)
    }
    
    func resetButton() {
        if filter.isHidden == true {
            filter.isHidden = false
        }
    }
    
    func dismiss(modalText: Array<String>) {
        self.modal_view.dismiss(animated: true, completion: nil)
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
            
                        let pin = MKPointAnnotation()
                        pin.coordinate = locat.coordinate
                        pin.title = business.name
                        pin.subtitle = business.category
                        self.temp_ann.annotation = pin
            
                        self.map.addAnnotation(self.temp_ann.annotation!)
                    
                    }
                    
                }
            }
        }
        
    }
    

    
    @IBAction func button_tapped() {
        
        if filter.isHidden == false {
            filter.isHidden = true
            map.removeAnnotations(self.map.annotations)
            showModal()
        }

    }
    
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "pin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //annotationView?.pinTintColor = UIColor.green
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    */
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selected_annotation = view.annotation as? MKPointAnnotation
        button.isHidden = false
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        button.isHidden = true
    }
    
    @IBAction func callout_tapped() {
        let placemark = MKPlacemark(coordinate: (self.selected_annotation?.coordinate)!)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.selected_annotation?.title
        mapItem.openInMaps()
    }

    
}
