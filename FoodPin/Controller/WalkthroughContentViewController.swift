//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Apple on 2018/8/14.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
            headingLabel.text = heading
        }
    }

    @IBOutlet var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
            subHeadingLabel.text = subHeading
        }
    }
    
    @IBOutlet var contentImageView: UIImageView! {
        didSet {
            contentImageView.image = UIImage(named: imageFile)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
