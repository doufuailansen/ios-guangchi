//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by Apple on 2018/8/9.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField, UITextFieldDelegate {
    
    var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    //var padding1 = UIEdgeInsets(top: 50, left: 10, bottom: -10, right: 10
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
