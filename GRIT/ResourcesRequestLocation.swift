//
//  ResourcesRequestLocation.swift
//  GRIT
//
//  Created by Jake Alvord on 5/31/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

func request_location_access(location_manager: CLLocationManager, map: MKMapView) {
    
    let status = CLLocationManager.authorizationStatus()
    
    switch status {
        
        case .authorizedAlways, .authorizedWhenInUse:
            location_manager.startUpdatingLocation()
            map.userTrackingMode = .follow
            map.showsUserLocation = true
            return
        
        case .denied, .restricted:
            //let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            //let region = MKCoordinateRegion(center: Locale[0], span: span)
            //map.setRegion(region, animated: true)
            return
        
        default:
            location_manager.requestWhenInUseAuthorization()
        
    }
    
}
