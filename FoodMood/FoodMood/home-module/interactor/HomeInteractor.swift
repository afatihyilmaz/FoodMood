//
//  HomeInteractor.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 10.01.2022.
//

import Foundation
import Alamofire

class HomeInteractor : PresenterToInteractorHomeProtocol {
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    func getAllFoods() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let res = try JSONDecoder().decode(YemeklerResponse.self, from: data)
                    var list = [Yemekler]()
                    if let fList = res.yemekler {
                        list = fList
                    }
                    self.homePresenter?.sendDataToPresenter(foodList: list)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
