//
//  HomeRouter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 10.01.2022.
//

import Foundation

class HomeRouter : PresenterToRouterHomeProtocol {
    static func createModule(ref: HomeVC) {
        let presenter = HomePresenter()
        
        //View için yetkilendir
        ref.homePresenterObject = presenter
        
        //Presenter için
        ref.homePresenterObject?.homeInteractor = HomeInteractor()
        ref.homePresenterObject?.homeView = ref
        
        //Interactor için
        ref.homePresenterObject?.homeInteractor?.homePresenter = presenter
    }
}
