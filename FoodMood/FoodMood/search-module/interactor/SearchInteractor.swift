//
//  SearchInteractor.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import Foundation
import Alamofire

class SearchInteractor : PresenterToInteractorSearchProtocol {
    var searchPresenter: InteractorToPresenterSearchProtocol?
    
    func getAllFoods() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let res = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    var list = [Foods]()
                    if let fList = res.yemekler {
                        list = fList
                    }
                    self.searchPresenter?.sendDataToPresenter(foodList: list)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
