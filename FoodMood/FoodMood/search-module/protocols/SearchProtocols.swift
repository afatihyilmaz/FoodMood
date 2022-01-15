//
//  SearchProtocol.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import Foundation

//Main protocol
protocol PresenterToInteractorSearchProtocol {
    var searchPresenter:InteractorToPresenterSearchProtocol? {get set}
    
    func getAllFoods()
}

//Main protocol
protocol ViewToPresenterSearchProtocol {
    var searchInteractor:PresenterToInteractorSearchProtocol? {get set}
    var searchView:PresenterToViewSearchProtocol? {get set}
    
    func getFoods()
}

//Taşıyıcı protocol
protocol InteractorToPresenterSearchProtocol {
    func sendDataToPresenter(foodList:Array<Foods>)
}

//Taşıyıcı Protocol
protocol PresenterToViewSearchProtocol {
    func sendDataToView(foodList:Array<Foods>)
}

//Router protocol
protocol PresenterToRouterSearchProtocol {
    static func createModule(ref:SearchVC)
}

