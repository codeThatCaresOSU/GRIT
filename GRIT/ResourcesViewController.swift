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

class CustomAnnotation : MKPointAnnotation {
    var phone_number : String?
}

class ResourcesViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, TutorialViewControllerDelegate, FilterViewControllerDelegate {
    
    let sub_view = UIView()
    
    let tutorial_view = TutorialViewController()
    let filter_view = FilterViewController()
    
    var location_manager : CLLocationManager!
    
    let map = MKMapView()
    var selected_annotation: CustomAnnotation?
    let locale = CLLocationCoordinate2DMake(39.9612, -82.9988)
    var phone_number: String?
    
    var food_view = Array<MKPointAnnotation>()
    var ged_view = Array<MKPointAnnotation>()
    var sec_view = Array<MKPointAnnotation>()
    var trans_view = Array<MKPointAnnotation>()
    var rec_view = Array<MKPointAnnotation>()
    
    let filter_button = UIButton()
    let directions_button = UIButton()
    let info_button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // requests location
        location_manager = CLLocationManager()
        location_manager.delegate = self
        
        // sets map delegate to self
        self.map.delegate = self
        
        // sets modal_view delegate to self
        self.filter_view.delegate = self
        
        // set tutorial_view delegate to self
        self.tutorial_view.delegate = self

        // gets standard sizes for the view
        let tab_height = (tabBarController?.tabBar.frame.size.height)!
        let width = self.view.bounds.width
        let total_height = self.view.bounds.height
        let height = total_height - tab_height
        
        // initializes subview - where all other view will go
        sub_view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        // initializes the map view
        map.frame = CGRect(x: 0, y: 0, width: width, height: sub_view.frame.height)
        
        // initializes the filter button sizes
        let button_size = width/4
        let status_bar_height = UIApplication.shared.statusBarFrame.height
        
        // initializes the filter button
        filter_button.frame = CGRect(x: status_bar_height, y: height - button_size - status_bar_height, width: button_size, height: button_size)
        filter_button.layer.cornerRadius = button_size/2
        filter_button.layer.masksToBounds = true
        filter_button.backgroundColor = UIColor.darkGray
        filter_button.setTitle("Filter", for: .normal)
        filter_button.setTitleColor(UIColor.white, for: .normal)
        filter_button.addTarget(self, action: #selector(show_filter), for: .touchUpInside)
        
        // initializes the directions button
        info_button.frame = CGRect(x: width - 1.5 * button_size - status_bar_height, y: height - 2 * button_size - 2 * status_bar_height, width: 1.5 * button_size, height: button_size)
        info_button.layer.cornerRadius = button_size/4
        info_button.layer.masksToBounds = true
        info_button.backgroundColor = UIColor.lightGray
        info_button.setTitle("Info", for: .normal)
        info_button.setTitleColor(UIColor.white, for: .normal)
        info_button.addTarget(self, action: #selector(send_to_phone), for: .touchUpInside)
        info_button.isHidden = true
        
        // initializes the directions button
        directions_button.frame = CGRect(x: width - 1.5 * button_size - status_bar_height, y: height - button_size - status_bar_height, width: 1.5 * button_size, height: button_size)
        directions_button.layer.cornerRadius = button_size/4
        directions_button.layer.masksToBounds = true
        directions_button.backgroundColor = UIColor.red
        directions_button.setTitle("Directions", for: .normal)
        directions_button.setTitleColor(UIColor.white, for: .normal)
        directions_button.addTarget(self, action: #selector(send_to_maps), for: .touchUpInside)
        directions_button.isHidden = true
        
        sub_view.addSubview(map)
        sub_view.addSubview(filter_button)
        sub_view.addSubview(directions_button)
        sub_view.addSubview(info_button)
        self.view.addSubview(sub_view)
        
        populate(categories: ["Food", "Second Chance Employer", "G.E.D.", "Recovery", "Transportation"])
    }
    
    
    // requests and sets users location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
            case .authorizedAlways, .authorizedWhenInUse:
            
                manager.startUpdatingLocation()
                map.userTrackingMode = .follow
                //let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                //let region = MKCoordinateRegion(center: (manager.location?.coordinate)!, span: span)
                //map.setRegion(region, animated: true)
                
                break
            
            case .denied, .restricted:
                
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: locale, span: span)
                map.setRegion(region, animated: true)
                
                break
            
            default:
                
                show_tutorial()
                manager.requestWhenInUseAuthorization()
                
                break
        }
        
    }
    
    func show_tutorial() {
        tutorial_view.modalPresentationStyle = .overFullScreen
        self.present(self.tutorial_view, animated: true, completion: nil)
    }
    
    func dismiss_tutorial() {
        self.tutorial_view.dismiss(animated: true, completion: nil)
    }
    
    @objc func show_filter() {

        self.map.removeAnnotations(self.map.annotations)
        
        filter_view.modalPresentationStyle = .overFullScreen
        self.present(self.filter_view, animated: true, completion: nil)
    }
    
    func dismiss_filter(categories: Array<String>) {
        self.dismiss(animated: true, completion: nil)
        //populate(categories: categories)
        repopulate(categories: categories)
    }
    
    @objc func send_to_maps() {
        let placemark = MKPlacemark(coordinate: (self.selected_annotation?.coordinate)!)
        let annotation = MKMapItem(placemark: placemark)
        annotation.name = self.selected_annotation?.title
        annotation.openInMaps()
    }
    
    @objc func send_to_phone() {
        if let url = URL(string: "tel://\(phone_number!)") {
            print(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selected_annotation = view.annotation as? CustomAnnotation
        self.phone_number = self.selected_annotation?.phone_number
        directions_button.isHidden = false
        info_button.isHidden = false;
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        directions_button.isHidden = true
        info_button.isHidden = true
    }
    
    func populate(categories: Array<String>) {
        
        FirebaseManager.sharedInstance.getBusinesses(flags: categories) {
            businesses in
            
            for business in businesses {
                
                if categories.contains(business.category) {
                    
                    let pin = CustomAnnotation()
                    pin.coordinate.latitude = business.lat
                    pin.coordinate.longitude = business.long
                    pin.title = business.name
                    pin.subtitle = business.category
                    pin.phone_number = business.phone
                    
                    print(business)
                    
                    if business.category == "Food" {
                        self.food_view.append(pin)
                    } else if business.category == "Second Chance Employer" {
                        self.sec_view.append(pin)
                    } else if business.category == "G.E.D." {
                        self.ged_view.append(pin)
                    } else if business.category == "Recovery" {
                        self.rec_view.append(pin)
                    } else if business.category == "Transportation" {
                        self.trans_view.append(pin)
                    }
                    
                }
 
            }
            
        }
        
    }
    
    func repopulate(categories: Array<String>) {
   
        if categories.contains("Food") {
           self.map.addAnnotations(food_view)
        }
        
        if categories.contains("Second Chance Employer") {
            self.map.addAnnotations(sec_view)
        }
        
        if categories.contains("G.E.D.") {
            self.map.addAnnotations(ged_view)
        }
        
        if categories.contains("Recovery") {
            self.map.addAnnotations(rec_view)
        }
        
        if categories.contains("Transportation") {
            self.map.addAnnotations(trans_view)
        }
        
    }

    
}


