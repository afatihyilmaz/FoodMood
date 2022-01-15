//
//  TableViewCell.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basketImageView: UIImageView!
    
    @IBOutlet weak var basketFoodNameLabel: UILabel!
    
    @IBOutlet weak var basketFoodCountLabel: UILabel!
    
    @IBOutlet weak var basketFoodPriceLabel: UILabel!
    
    @IBOutlet weak var cellBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackgroundView.layer.cornerRadius = 10.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
