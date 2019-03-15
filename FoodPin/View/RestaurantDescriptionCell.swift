//
//  RestaurantDescriptionCell.swift
//  FoodPin
//
//  Created by Apple on 2018/8/3.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit

class RestaurantDescriptionCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.lineBreakMode = .byCharWrapping
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
