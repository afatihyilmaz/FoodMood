//
//  FoodBasketVC.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import UIKit
import Kingfisher

class FoodBasketVC: UIViewController {

    @IBOutlet weak var basketTabItem: UITabBarItem!
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var basketBackgroundView: UIView!
    
    var basketPresenterObject:ViewToPresenterBasketProtocol?
    var foodList = [FoodBasket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketBackgroundView.isHidden = true

        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        BasketRouter.createModule(ref: self)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        basketPresenterObject?.getFoods(kullanici_adi: "ahmetfatih")
        
    }
    
    func calculateTotalCost(){
        var totalCost = 0
        var foodPrice = 0
        
        for f in foodList {
            foodPrice = Int(f.yemek_fiyat!)! * Int(f.yemek_siparis_adet!)!
            totalCost += foodPrice
        }
        self.totalPriceLabel.text = "\(totalCost) ₺"
    }
    
    @IBAction func confirmBasketTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Congrats", message: "Your order has been received.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Done", style: .cancel) { action in
            self.deleteAllBasketItems()
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
        
    }
    
    func deleteAllBasketItems(){
            for food in foodList {
                basketPresenterObject?.delete(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: food.kullanici_adi!)
            }
        //Set Basket Badge Value
        let ud = UserDefaults.standard
        var basketItemCount = ud.integer(forKey: "basketItemCount")
        basketItemCount = 0
        ud.set(basketItemCount, forKey: "basketItemCount")
        self.basketTabItem.badgeValue = nil
        }
}

extension FoodBasketVC : PresenterToViewBasketProtocol {
    func sendDataToView(foodList: Array<FoodBasket>) {
        self.foodList = foodList
        calculateTotalCost()
        if foodList.isEmpty {
            basketBackgroundView.isHidden = true
        }else {
            basketBackgroundView.isHidden = false
        }
        DispatchQueue.main.async {
            self.basketTableView.reloadData()
        }
    }
}

extension FoodBasketVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketFood = foodList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableViewCell
        cell.basketFoodNameLabel.text = basketFood.yemek_adi
        cell.basketFoodCountLabel.text = "Count: \(basketFood.yemek_siparis_adet!)"
        cell.basketFoodPriceLabel.text = "Price : \(Int(basketFood.yemek_fiyat!)! * Int(basketFood.yemek_siparis_adet!)!) ₺"
        
        DispatchQueue.main.async {
            cell.basketImageView.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basketFood.yemek_resim_adi!)"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Create Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, bool) in
            let food = self.foodList[indexPath.row]
           
            //Create Alert
            let alert = UIAlertController(title: "Delete Process", message: "delete \(food.yemek_adi!)?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in }
            alert.addAction(cancelAction)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { action in
                self.basketPresenterObject?.delete(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: food.kullanici_adi!)
               
                //Set Basket Badge Value
                let ud = UserDefaults.standard
                var basketItemCount = ud.integer(forKey: "basketItemCount")
                basketItemCount -= 1
                ud.set(basketItemCount, forKey: "basketItemCount")
                if basketItemCount > 0 {
                    let tabBar = self.tabBarController!.tabBar
                    let tabItem = tabBar.items![1]
                    tabItem.badgeValue = String(basketItemCount)
                    print("basketItemCount: \(basketItemCount)")
                }else {
                    self.basketTabItem.badgeValue = nil
                }
            }
            
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
}


