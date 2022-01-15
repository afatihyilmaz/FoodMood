//
//  FoodTableViewCell.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 11.01.2022.
//

import UIKit

protocol CellProtocol {
    func addBasketTapped(indexPath:IndexPath)
}

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var FoodPriceLabel: UILabel!
    
    var cellProtocol:CellProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addBasket(_ sender: Any) {
        cellProtocol?.addBasketTapped(indexPath: indexPath!)
    }
}
