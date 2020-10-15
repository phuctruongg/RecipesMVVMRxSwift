//
//  RecipesCellViewModel.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import Foundation
import RxSwift
struct RecipesCellViewModel {
     let disposeBag = DisposeBag()
    //Presentation - Poster
    var recipesThumnail: String?
    //Presentation - Content - Header
    var recipesDescription: String?
    var recipesTitle: String?
    //Initializer
    init(recipesThumnail: String, recipesDescription: String, recipesTitle: String) {
        self.recipesTitle = recipesTitle
        self.recipesDescription = recipesDescription
        self.recipesThumnail =  recipesThumnail
    }
}
