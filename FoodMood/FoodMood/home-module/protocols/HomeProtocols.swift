//
//  HomeProtocols.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 10.01.2022.
//

import Foundation

//Main protocol
protocol PresenterToInteractorHomeProtocol {
    var homePresenter:InteractorToPresenterHomeProtocol? {get set}
    
    func getAllFoods()
}

//Main protocol
protocol ViewToPresenterHomeProtocol {
    var homeInteractor:PresenterToInteractorHomeProtocol? {get set}
    var homeView:PresenterToViewHomeProtocol? {get set}
    
    func getFoods()
}

//Taşıyıcı protocol
protocol InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foodList:Array<Foods>)
}

//Taşıyıcı Protocol
protocol PresenterToViewHomeProtocol {
    func sendDataToView(foodList:Array<Foods>)
}

//Router protocol
protocol PresenterToRouterHomeProtocol {
    static func createModule(ref:HomeVC)
}
