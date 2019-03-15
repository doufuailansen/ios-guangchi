//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Apple on 2018/8/5.
//  Copyright © 2018年 QianMo. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle : UIViewController? {
        return topViewController
    }
}
