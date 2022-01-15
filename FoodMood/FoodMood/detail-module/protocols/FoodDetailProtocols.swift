//
//  FoodDetailProtocols.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 11.01.2022.
//

import Foundation

protocol PresenterToInteractorFoodDetailProtocol {
    func addFoodBasket(yemek_adi:String, yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor:PresenterToInteractorFoodDetailProtocol? {get set}
    
    func addFood(yemek_adi:String, yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol PresenterToRouterFoodDetailProtocol {
    static func createModule(ref:FoodDetailVC)
}
