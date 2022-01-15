//
//  BasketInteractor.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import Foundation
import Alamofire

class BasketInteractor : PresenterToInteractorBasketProtocol {
    var basketPresenter: InteractorToPresenterBasketProtocol?
    
    func getAllFoods(kullanici_adi: String) {
        let params : Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let res = try JSONDecoder().decode(FoodBasketResponse.self, from: data)
                    var list = [FoodBasket]()
                    if let basketList = res.sepet_yemekler {
                        list = basketList
                    }
                    self.basketPresenter?.sendDataToPresenter(foodList: list)
                }catch{
                    self.basketPresenter?.sendDataToPresenter(foodList: [])
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String) {
//        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_id":kullanici_adi]
//
//        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
//            if let data = response.data {
//                do{
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
//                        print(json)
//                        self.getAllFoods(kullanici_adi: kullanici_adi)
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
//        }
//
//    }
    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String) {
            let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]

            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response { response in
                if let data = response.data{

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            print(json)

//                            //sepet sayi
//                            var sayi = UserDefaults.standard.integer(forKey: "sepet")
//                            if sayi != 0{
//                                sayi = sayi - 1
//                            }
//                            UserDefaults.standard.set(sayi, forKey: "sepet")
                            self.getAllFoods(kullanici_adi: kullanici_adi)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }

    
}
