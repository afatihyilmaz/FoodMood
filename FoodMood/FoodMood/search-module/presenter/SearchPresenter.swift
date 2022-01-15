//
//  SearchPresenter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import Foundation

class SearchPresenter : ViewToPresenterSearchProtocol {
    var searchInteractor: PresenterToInteractorSearchProtocol?
    
    var searchView: PresenterToViewSearchProtocol?
    
    func getFoods() {
        searchInteractor?.getAllFoods()
    }
}

extension SearchPresenter : InteractorToPresenterSearchProtocol {
    func sendDataToPresenter(foodList: Array<Yemekler>) {
        searchView?.sendDataToView(foodList: foodList)
    }
}
