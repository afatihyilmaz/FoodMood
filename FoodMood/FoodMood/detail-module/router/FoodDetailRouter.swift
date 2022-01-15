//
//  FoodDetailRouter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 11.01.2022.
//

import Foundation

class FoodDetailRouter : PresenterToRouterFoodDetailProtocol {
    static func createModule(ref: FoodDetailVC) {
        ref.foodDetailPresenterObject = FoodDetailPresenter()
        ref.foodDetailPresenterObject?.foodDetailInteractor = FoodDetailInteractor()
    }
}
