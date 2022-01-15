//
//  DetailVC.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 11.01.2022.
//

import UIKit
import Kingfisher

class FoodDetailVC: UIViewController {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    @IBOutlet weak var stepperBackgorundView: UIView!
    @IBOutlet weak var foodDescribtionLabel: UILabel!
    
    @IBOutlet weak var foodCountLabel: UILabel!
    
    var foodCount = 1
    var basketItemCount = 0
    
    var foodDetailPresenterObject : ViewToPresenterFoodDetailProtocol?
    var food:Foods?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ud = UserDefaults.standard
        
        basketItemCount = ud.integer(forKey: "basketItemCount")
        
        stepperBackgorundView.layer.borderColor = UIColor.black.cgColor
        stepperBackgorundView.layer.borderWidth = 0.5
        stepperBackgorundView.layer.cornerRadius = 10
        
        foodCount = foodCountLabel.tag
        
        if let f = food {
            self.navigationItem.title = f.yemek_adi
            let imageUrl = "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)"
            foodNameLabel.text = f.yemek_adi
            foodPriceLabel.attributedText = attributedString(firstString: "Price", secondString: f.yemek_fiyat!)
            
            DispatchQueue.main.async {
                self.foodImageView.kf.setImage(with: URL(string: imageUrl))
            }
        }
        FoodDetailRouter.createModule(ref: self)
    }
    
    //Custom Label
    func attributedString(firstString:String, secondString:String) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(firstString)  ")
        attributedText.append(NSAttributedString(string: "\(secondString) ₺", attributes: [.font: UIFont.boldSystemFont(ofSize: 25)]))
        return attributedText
    }
    
    @IBAction func increaseCountTapped(_ sender: Any) {
        foodCount += 1
        foodCountLabel.text = "\(foodCount)"
        foodCountLabel.tag = foodCount
        foodPriceLabel.attributedText = attributedString(firstString: "Price", secondString: String((foodCount * Int((food?.yemek_fiyat)!)!)))
    }
    
    @IBAction func decreaseCountTapped(_ sender: Any) {
        if foodCount > 1 {
            foodCount -= 1
            foodCountLabel.text = "\(foodCount)"
            foodCountLabel.tag = foodCount
            foodPriceLabel.attributedText = attributedString(firstString: "Price", secondString: String((foodCount * Int((food?.yemek_fiyat)!)!)))
        }
    }
    
    
    @IBAction func addBasketTapped(_ sender: Any) {
        if let f = food {
            foodDetailPresenterObject?.addFood(yemek_adi: f.yemek_adi!, yemek_resim_adi:f.yemek_resim_adi!, yemek_fiyat: Int(f.yemek_fiyat!)!, yemek_siparis_adet: foodCount, kullanici_adi: "ahmetfatih")
            
            //getting UserDefaults value for BasketIcon Badge value
            basketItemCount += 1
            let ud = UserDefaults.standard
            ud.set(basketItemCount, forKey: "basketItemCount")
            
            //Create alert
            let alert = UIAlertController(title: "Congrats", message: "\(f.yemek_adi!) added to basket. Would you like to continue shopping?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "No", style: .destructive){ action in   }
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Yes", style: .cancel) { action in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        
    }
}
