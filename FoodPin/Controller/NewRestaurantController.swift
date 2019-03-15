//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var restaurant: RestaurantMO!
    var databaseRestaurant: Restaurants = Restaurants()
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.textColor = UIColor.darkGray
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: UITextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.textColor = UIColor.darkGray
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: UITextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.textColor = UIColor.darkGray
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: UITextField! {
        didSet {
            phoneTextField.delegate = self
            phoneTextField.textColor = UIColor.darkGray
            phoneTextField.tag = 4
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.layer.cornerRadius = 5.0
            descriptionTextView.layer.masksToBounds = true
            descriptionTextView.tag = 5
        }
    }
    
    @IBOutlet var saveButtuon: UIBarButtonItem! {
        didSet {
            saveButtuon.action = #selector(saveButtonTapped(sender:))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoRequestController = UIAlertController(title: "", message: "要怎么上传图片呢？", preferredStyle: .actionSheet)
            let photoLibraryAction = UIAlertAction(title: "打开相册", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            let cameraAction = UIAlertAction(title: "打开相机", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            let backAction = UIAlertAction(title: "返回", style: .destructive, handler: nil)
            
            photoRequestController.addAction(cameraAction)
            photoRequestController.addAction(photoLibraryAction)
            photoRequestController.addAction(backAction)
            
            present(photoRequestController, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let top = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        top.isActive = true
        
        let bottom = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottom.isActive = true
        
        let leading = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailing.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped(sender: UIBarButtonItem) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.address = addressTextField.text
            restaurant.phone = phoneTextField.text
            restaurant.summary = descriptionTextView.text
            restaurant.isVisited = false
            
            if let restaurantImage = photoImageView.image {
                restaurant.image = restaurantImage.pngData()
            }

            print("Saving data to context...")
            appDelegate.saveContext()
        }
        
        databaseRestaurant.name = nameTextField.text
        databaseRestaurant.type = typeTextField.text
        databaseRestaurant.location = addressTextField.text
        databaseRestaurant.phone = phoneTextField.text
        databaseRestaurant.summary = descriptionTextView.text
        if let restaurantImage = photoImageView.image {
            databaseRestaurant.image = restaurantImage.pngData()
        }
        
        
        let dbOperation = Database.init()
        let addBool = dbOperation.addRestaurant(restaurant: databaseRestaurant)
        print(addBool)
        
        
        dismiss(animated: true, completion: nil)
    }
//
//    func connectDatabase() {
//        let dbOperation = Database.init()
//        dbOperation.addRestaurant(restaurant: databaseRestaurant)
////        for index in 0...(restaurants.count - 1) {
////            print("\(restaurants[index])")
////        }
//    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
