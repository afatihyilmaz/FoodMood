//
//  HomePresenter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 10.01.2022.
//

import Foundation

class HomePresenter : ViewToPresenterHomeProtocol {
    var homeInteractor: PresenterToInteractorHomeProtocol?
    
    var homeView: PresenterToViewHomeProtocol?
    
    func getFoods() {
        homeInteractor?.getAllFoods()
    }
}

extension HomePresenter : InteractorToPresenterHomeProtocol {
    func sendDataToPresenter(foodList: Array<Yemekler>) {
        homeView?.sendDataToView(foodList: foodList)
    }
}
