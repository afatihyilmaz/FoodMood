//
//  BasketProtocols.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import Foundation

protocol PresenterToInteractorBasketProtocol {
    var basketPresenter:InteractorToPresenterBasketProtocol? {get set}
    
    func getAllFoods(kullanici_adi:String)
    func deleteFood(sepet_yemek_id:Int,kullanici_adi:String)
}

protocol ViewToPresenterBasketProtocol {
    var basketInteractor:PresenterToInteractorBasketProtocol? {get set}
    var basketView:PresenterToViewBasketProtocol? {get set}
    
    func getFoods(kullanici_adi:String)
    func delete(sepet_yemek_id:Int,kullanici_adi:String)
}

protocol InteractorToPresenterBasketProtocol {
    func sendDataToPresenter(foodList:Array<FoodBasket>)
}

protocol PresenterToViewBasketProtocol {
    func sendDataToView(foodList:Array<FoodBasket>)
}

protocol PresenterToRouterBasketProtocol {
    static func createModule(ref: FoodBasketVC)
}
