//
//  SearchRouter.swift
//  FoodMood
//
//  Created by Ahmet Fatih YILMAZ on 15.01.2022.
//

import Foundation

class SearchRouter : PresenterToRouterSearchProtocol {
    static func createModule(ref: SearchVC) {
        let presenter = SearchPresenter()
        
        //View için yetkilendir
        ref.searchPresenterObject = presenter
        
        //Presenter için
        ref.searchPresenterObject?.searchInteractor = SearchInteractor()
        ref.searchPresenterObject?.searchView = ref
        
        //Interactor için
        ref.searchPresenterObject?.searchInteractor?.searchPresenter = presenter
    }
}
