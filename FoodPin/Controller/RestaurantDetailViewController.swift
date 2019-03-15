//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Apple on 2018/8/2.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! RestaurantDetailCell
            cell.imageTypeView.image = UIImage(named: "phone")
            cell.label.text = restaurant.phone
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! RestaurantDetailCell
            cell.imageTypeView.image = UIImage(named: "map")
            cell.label.text = restaurant.address
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! RestaurantDescriptionCell
            cell.descriptionLabel.text = restaurant.summary
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RestaurantSplitCell
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! RestaurantMapCell
            cell.configure(location: restaurant.address!)
            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }

    }
    
    @IBOutlet var restaurantImageView: UIImageView! {
        didSet {
            restaurantImageView.image = restaurantImage
        }
    }
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var restaurantType: UILabel!
    @IBOutlet var restaurantLocation: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }
    @IBOutlet var rateImageView: UIImageView!
//        {
//        didSet {
//            rateImageView.image = UIImage(named: restaurant.rating!)
//        }
//    }
//
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rate(segue: UIStoryboardSegue) {
        
        dismiss(animated: true) {
            if let rating = segue.identifier {
                self.restaurant.rating = rating
                self.rateImageView.image = UIImage(named: rating)
                
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    appDelegate.saveContext()
                }
                
                let scaleTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.rateImageView.transform = scaleTransform
                self.rateImageView.alpha = 0
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                    self.rateImageView.alpha = 1
                    self.rateImageView.transform = .identity
                }, completion: nil)
            }
        }
    }
    
    var restaurantImage: UIImage!
    var nameString = ""
    var typeString = ""
    var locationString = ""
    var restaurant: RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
    }
    
    func setUpViews() {

        //restaurantImageView.image = UIImage(named: restaurantImageName)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
        //navigationController?.hidesBarsOnSwipe = false
        //restaurantType.text = typeString
        restaurantName.text = nameString
        restaurantLocation.text = typeString
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //restaurantImageView.insetsLayoutMarginsFromSafeArea = false
        heartImageView.isHidden = (restaurant.isVisited) ? false : true
        
        if let rating = restaurant.rating {
            rateImageView.image = UIImage(named: rating)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
        
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! RestaurantReviewController
            destinationController.restaurant = restaurant
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
