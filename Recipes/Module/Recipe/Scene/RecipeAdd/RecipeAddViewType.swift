
//
//  RecipeAddViewControllerType.swift
//  Recipes
//
//  Created by Apple on 10/19/20.
//

import Foundation
import Foundation
import RxSwift
import RxCocoa

protocol RecipeAddViewType : NSObjectProtocol {
    var didAddRecipe : PublishSubject <Recipe> { get}
    var pos: String { get set}
}



typealias RecipesAddViewControllerType = UIViewController & RecipeAddViewType


struct AddIntent {
    let selectedRecipe: Recipe
}
