//
//  SearchTableViewCell.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchFoodImageView: UIImageView!
    @IBOutlet weak var searchFoodNameLabel: UILabel!
    
    @IBOutlet weak var searchFoodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
