//
//  AboutViewController.swift
//  DevslopesTutorials
//
//  Created by Per Kristensen on 21/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import MapKit

class AboutViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        let addressCoordinate = CLLocationCoordinate2D(latitude: 55.71961, longitude:12.3924643)
        annotation.coordinate = addressCoordinate
        annotation.title = "Come visit us"
        annotation.subtitle = ":D"
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: addressCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
