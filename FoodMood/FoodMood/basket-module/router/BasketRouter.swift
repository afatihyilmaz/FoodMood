//
//  BasketRouter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 13.01.2022.
//

import Foundation

class BasketRouter : PresenterToRouterBasketProtocol {
    static func createModule(ref: FoodBasketVC) {
        let presenter = BasketPresenter()
        
        //View
        ref.basketPresenterObject = presenter
        //Presenter
        ref.basketPresenterObject?.basketInteractor = BasketInteractor()
        ref.basketPresenterObject?.basketView = ref
        //Interactor
        ref.basketPresenterObject?.basketInteractor?.basketPresenter = presenter
    }
    
    
}
