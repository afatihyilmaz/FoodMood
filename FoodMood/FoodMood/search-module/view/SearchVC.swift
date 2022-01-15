//
//  SearchVC.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import UIKit
import Kingfisher

class SearchVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchPresenterObject:ViewToPresenterSearchProtocol?
    
    var foodList = [Yemekler]()
    var searchList = [Yemekler]()
    var basketItemCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        SearchRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchPresenterObject?.getFoods()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToDetailVC" {
            let food = sender as? Yemekler
            let destinationVC = segue.destination as! FoodDetailVC
            destinationVC.food = food
        }
    }
}

extension SearchVC : PresenterToViewSearchProtocol {
    func sendDataToView(foodList: Array<Yemekler>) {
        self.foodList = foodList
        self.searchList = self.foodList
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
}

extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchList = self.foodList.filter { food in
            if food.yemek_adi!.lowercased().contains(searchText.lowercased()) || searchText == ""
            { return true
            }else {
                return false
            }
        }
        self.searchTableView.reloadData()
    }
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = searchList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.searchFoodNameLabel.text = food.yemek_adi
        cell.searchFoodPriceLabel.text = "Price : \(food.yemek_fiyat!) ₺"
        let foodImageUrl = "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"
        cell.searchFoodImageView.kf.setImage(with: URL(string: foodImageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = searchList[indexPath.row]
        performSegue(withIdentifier: "searchToDetailVC", sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
