//
//  LoginViewType.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipesViewType : NSObjectProtocol {
    func routeToRecipeDetail(recipe: Recipe)
    func routeToAddRecipe()
    func routeToUpdateRecipe(recipe: Recipe)
}



typealias RecipesViewControllerType = UIViewController & RecipesViewType



//
struct DetailNavigationIntent {
    let selectedRecipe: Recipe
}


protocol RecipesNavigationViewType {
}

typealias RecipesNavigationControllerType = UINavigationController & RecipesNavigationViewType
//
