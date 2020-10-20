
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

protocol RecipeDetailViewType : NSObjectProtocol {
    var editRecipe: PublishSubject <Recipe> { get}
    var deleteRecipe: PublishSubject <Void> {get}
    var recipeIntent: Recipe {get set}
    func showDeleteAlert()
    func routeBack()
}



typealias RecipesDetailViewControllerType = UIViewController & RecipeDetailViewType



