//
//  DiscoverCell.swift
//  FoodPin
//
//  Created by Apple on 2018/8/25.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {
    
    @IBOutlet var restaurantImageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var typeLabel: UILabel?
    @IBOutlet var addressLabel: UILabel?
    @IBOutlet var phoneLabel: UILabel?
    @IBOutlet var summaryLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
