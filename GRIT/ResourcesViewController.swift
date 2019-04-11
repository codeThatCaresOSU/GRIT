//
//  ResourcesViewController.swift
//  GRIT
//BAD
//  Created by Jake Alvord on 4/30/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResourcesViewController: UIViewController {
    
    let subview = UIView()
    let map_view = UIView()
    let map = MKMapView()
    let locationManager = CLLocationManager()
    let temp_ann = MKAnnotationView()
    
    let locale = CLLocationCoordinate2DMake(39.9612, -82.9988)

    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        
        let spacer = CGFloat(10)
        let d_spacer = CGFloat(20)
        let x_spot = CGFloat(0)
        var y_height = CGFloat(0)
        
        // ------------------------------------------------------------------------------------
        // subview
        // ------------------------------------------------------------------------------------
        
        subview.frame = CGRect(x: spacer, y: d_spacer, width: self.view.bounds.width - d_spacer, height: self.view.bounds.height - 69 - spacer)
        
        let x_width = subview.bounds.width
        let t_height = subview.bounds.height
        
        // ------------------------------------------------------------------------------------
        // title
        // ------------------------------------------------------------------------------------
        
        let title_view = UIView(frame: CGRect(x: x_spot, y: y_height, width: x_width, height: t_height/16))
        
        let title = UILabel(frame: CGRect(x: x_spot, y: x_spot, width: x_width, height: title_view.bounds.height))
        
        title.text = "Resources"
        title.textColor = UIColor.black
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.thin)
        
        title_view.addSubview(title)
        
        y_height += title_view.bounds.height + spacer
        
        // ------------------------------------------------------------------------------------
        // message additions
        // ------------------------------------------------------------------------------------
        
        let message_view = UIView(frame: CGRect(x: x_spot, y: y_height, width: x_width, height: t_height/8))
        
        let message = UILabel(frame: CGRect(x: x_spot, y: x_spot, width: x_width, height: message_view.bounds.height))
        
        message.text = "A map of helpful resources to get back on your feet! Tap any filter to get specific locations and tap again to remove them"
        message.textColor = UIColor.black
        message.textAlignment = .center
        message.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        message.numberOfLines = 10
        message.layer.cornerRadius = 10
        message.clipsToBounds = true
        message.backgroundColor = successColor
        
        message_view.addSubview(message)
        
        y_height += message_view.bounds.height + spacer
        
        // ------------------------------------------------------------------------------------
        // map additions
        // ------------------------------------------------------------------------------------
        
        map_view.frame = CGRect(x: x_spot, y: y_height, width: x_width, height: t_height/2)
        
        map.frame = CGRect(x: x_spot, y: x_spot, width: x_width, height: map_view.bounds.height)
        map.layer.cornerRadius = 10
        map.showsUserLocation = true
        
        map_view.addSubview(map)
        
        y_height += map_view.bounds.height + spacer
        
        // ------------------------------------------------------------------------------------
        // filter additions
        // ------------------------------------------------------------------------------------
        
        let filter_view = UIView(frame: CGRect(x: x_spot, y: y_height, width: x_width, height: (2 * t_height)/8))
        
        let button_size = x_width/5
        let slide_one = UIView(frame: CGRect(x: x_spot, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        let temp = filter_view.bounds.height
        
        // ------------------------------------------------------------------------------------
        
        let food_button = UIButton()
        let food_label = UILabel()
        buttonSetUp(name: "food", sender: food_button, num: 1, x_spot: x_spot, temp: temp, button_size: button_size, x_width: x_width, but: CGFloat(1), title: food_label)
        slide_one.addSubview(food_button)
        slide_one.addSubview(food_label)
        
        // ------------------------------------------------------------------------------------
        
        let slide_two = UIView(frame: CGRect(x: x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        
        let ged_button = UIButton()
        let ged_label = UILabel()
        buttonSetUp(name: "ged", sender: ged_button, num: 1, x_spot: x_spot, temp: temp, button_size: button_size, x_width: x_width, but: CGFloat(4), title: ged_label)
        slide_two.addSubview(ged_button)
        slide_two.addSubview(ged_label)
        
        // ------------------------------------------------------------------------------------
        
        let slide_three = UIView(frame: CGRect(x: 2 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        
        let sce_button = UIButton()
        let sce_label = UILabel()
        buttonSetUp(name: "second chance employers", sender: sce_button, num: 3, x_spot: x_spot, temp: temp, button_size: button_size, x_width: x_width, but: CGFloat(2), title: sce_label)
        slide_three.addSubview(sce_button)
        slide_three.addSubview(sce_label)
        
        // ------------------------------------------------------------------------------------
        
        let slide_four = UIView(frame: CGRect(x: 3 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        
        let recovery_button = UIButton()
        let recovery_label = UILabel()
        buttonSetUp(name: "recovery", sender: recovery_button, num: 1, x_spot: x_spot, temp: temp, button_size: button_size, x_width: x_width, but: CGFloat(5), title: recovery_label)
        slide_four.addSubview(recovery_button)
        slide_four.addSubview(recovery_label)
        
        // ------------------------------------------------------------------------------------
        
        let slide_five = UIView(frame: CGRect(x: 4 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        
        let transportation_button = UIButton()
        let transportation_label = UILabel()
        buttonSetUp(name: "transportation", sender: transportation_button, num: 1, x_spot: x_spot, temp: temp, button_size: button_size, x_width: x_width, but: CGFloat(3), title: transportation_label)
        slide_five.addSubview(transportation_button)
        slide_five.addSubview(transportation_label)
        
        // adding filter subviews
        
        filter_view.addSubview(slide_one)
        filter_view.addSubview(slide_two)
        filter_view.addSubview(slide_three)
        filter_view.addSubview(slide_four)
        filter_view.addSubview(slide_five)
        
        // ------------------------------------------------------------------------------------
        // subview additions
        // ------------------------------------------------------------------------------------
        
        subview.addSubview(title_view)
        subview.addSubview(message_view)
        subview.addSubview(map_view)
        subview.addSubview(filter_view)
        
        self.view.addSubview(subview)
        
        self.view.backgroundColor = UIColor.white
        
    }

    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            map.userTrackingMode = .follow
            return
            
        case .denied, .restricted:
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: locale, span: span)
            map.setRegion(region, animated: true)
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func buttonSetUp(name: String, sender: UIButton, num: Int, x_spot: CGFloat, temp: CGFloat, button_size: CGFloat, x_width: CGFloat, but: CGFloat, title: UILabel) {
        
        let x = CGFloat(0);
        var y = CGFloat(0);
        
        if (but < 4) {
            y = temp/3 - button_size/2
        } else {
            y = (2 * temp)/3 - button_size/2
        }
        
        sender.frame = CGRect(x: x, y: y, width: button_size, height: button_size)
        sender.layer.cornerRadius = button_size/2
        sender.layer.masksToBounds = true
        sender.backgroundColor = colorMaster
        
        var image = UIImage()
        
        if (but == 1) {
            image = #imageLiteral(resourceName: "food.png")
            title.text = "Food"
            sender.setTitle("Food", for: .normal)
        } else if (but == 2) {
            image = #imageLiteral(resourceName: "humans.png")
            title.text = "Employers"
        } else if (but == 3) {
            image = #imageLiteral(resourceName: "refresh.png")
            title.text = "Recovery"
        } else if (but == 4) {
            image = #imageLiteral(resourceName: "diploma.png")
            title.text = "GED"
        } else if (but == 5) {
            image = #imageLiteral(resourceName: "bus.png")
            title.text = "Transportation"
        }
        
        sender.setImage(image, for: .normal)
        sender.imageEdgeInsets = UIEdgeInsetsMake(button_size/6,button_size/6,button_size/6,button_size/6)
        
        title.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
        title.textAlignment = .center
        title.sizeToFit()
        let new_x = button_size/2 - title.bounds.width/2
        title.frame = CGRect(x: new_x, y: y + button_size + 5, width: title.bounds.width, height: title.bounds.height)
        
        sender.addTarget(self, action: #selector(button_tapped(sender:)), for: .touchDown)
        
    }
    
    @IBAction func button_tapped(sender: UIButton) {
        
        if sender.backgroundColor == colorMaster {
            sender.backgroundColor = UIColor.lightGray
            
            if (sender.titleLabel?.text == "Food") {
                
                let pin = MKPointAnnotation()
                pin.title = "Columbus"
                pin.coordinate = locale
                temp_ann.annotation = pin
                
                map.addAnnotation(temp_ann.annotation!)
                
                
            }
        } else if sender.backgroundColor == UIColor.lightGray {
                sender.backgroundColor = colorMaster
                map.removeAnnotations(map.annotations)
        }

    }
}
