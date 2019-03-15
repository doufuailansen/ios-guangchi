//
//  RestaurantMapCell.swift
//  FoodPin
//
//  Created by Apple on 2018/8/5.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapCell: UITableViewCell {
    
    @IBOutlet var mapView: MKMapView!
    
    func configure(location: String) {
        //get location
        let geoCoder = CLGeocoder()
        
        print(location)
        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                //get the first placemark
                let placemark = placemarks[0]
                //add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    //display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    //set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
