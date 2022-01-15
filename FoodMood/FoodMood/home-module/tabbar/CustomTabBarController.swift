//
//  CustomTabBarController.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import Foundation
import UIKit

class CustomTabBarController : UITabBarController {
    @IBInspectable var initialIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initialIndex
    }
}
