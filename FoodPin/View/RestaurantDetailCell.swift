//
//  RestaurantDetailCell.swift
//  FoodPin
//
//  Created by Apple on 2018/8/3.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit

class RestaurantDetailCell: UITableViewCell {
    
    @IBOutlet var imageTypeView: UIImageView!
    @IBOutlet var label: UILabel! {
        didSet {
            label.numberOfLines = 0
        }
    }
    
    var imageName: String!
    var labelString: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
