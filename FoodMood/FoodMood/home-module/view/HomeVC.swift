//
//  ViewController.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 10.01.2022.
//

import UIKit
import Kingfisher


class HomeVC: UIViewController {

    let foodBaseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/"
    
    @IBOutlet weak var cvFoodImageView: UIImageView!
    @IBOutlet weak var cvFoodNameLabel: UILabel!
    @IBOutlet weak var cvFoodPriceLabel: UILabel!
    @IBOutlet weak var foodsTableView: UITableView!
    
    var foodList = [Foods]()
    var homePresenterObject:ViewToPresenterHomeProtocol?
    var basketItemCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodsTableView.delegate = self
        foodsTableView.dataSource = self
        
        HomeRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenterObject?.getFoods()

        //Set Basket Badge Value
        let ud = UserDefaults.standard
        basketItemCount = ud.integer(forKey: "basketItemCount")
        if basketItemCount > 0 {
            let tabBar = self.tabBarController!.tabBar
            let tabItem = tabBar.items![1]
            tabItem.badgeValue = String(basketItemCount)
            print("basketItemCount: \(basketItemCount)")
        }
    }
    // Custom label
    func attributedString(firstString:String, secondString:String) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(firstString)  ")
        attributedText.append(NSAttributedString(string: "\(secondString) ₺", attributes: [.font: UIFont.boldSystemFont(ofSize: 25)]))
        return attributedText
    }
}
//MARK: ext. TableviewDelegate
extension HomeVC : UITableViewDelegate, UITableViewDataSource, CellProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
        cell.foodNameLabel.text = food.yemek_adi
        cell.FoodPriceLabel.text = "Price : \(food.yemek_fiyat!) ₺"
        let foodImageUrl = self.foodBaseUrl + food.yemek_resim_adi!
        cell.foodImageView.kf.setImage(with: URL(string: foodImageUrl))
        
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let food = sender as? Foods
            let destinationVC = segue.destination as! FoodDetailVC
            destinationVC.food = food
        }
    }
    
    func addBasketTapped(indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: food)
    }
    
    
}

extension HomeVC : PresenterToViewHomeProtocol {
    func sendDataToView(foodList: Array<Foods>) {
        self.foodList = foodList
        initPopularFoodCardView()
        DispatchQueue.main.async {
            self.foodsTableView.reloadData()
        }
    }
    
    func initPopularFoodCardView(){
        let cvFood = foodList[4]
        cvFoodNameLabel.text = cvFood.yemek_adi
        cvFoodPriceLabel.attributedText = attributedString(firstString: "Price", secondString: cvFood.yemek_fiyat!)
        let foodImageUrl = foodBaseUrl + cvFood.yemek_resim_adi!
        cvFoodImageView.kf.setImage(with: URL(string: foodImageUrl))
    }
}
