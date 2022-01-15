//
//  BasketPresenter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import Foundation

class BasketPresenter : ViewToPresenterBasketProtocol {
    var basketInteractor: PresenterToInteractorBasketProtocol?
    
    var basketView: PresenterToViewBasketProtocol?
    
    func getFoods(kullanici_adi: String) {
        basketInteractor?.getAllFoods(kullanici_adi: kullanici_adi)
    }
    
    func delete(sepet_yemek_id: Int, kullanici_adi: String) {
        basketInteractor?.deleteFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    
}

extension BasketPresenter : InteractorToPresenterBasketProtocol {
    func sendDataToPresenter(foodList: Array<FoodBasket>) {
        basketView?.sendDataToView(foodList: foodList)
    }
}
