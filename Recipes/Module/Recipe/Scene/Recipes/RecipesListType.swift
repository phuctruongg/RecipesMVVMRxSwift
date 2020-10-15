//
//  RecipesListType.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//

import UIKit
import RxDataSources

typealias RecipesItem = RecipesCellViewModel
typealias RecipesSection = SectionModel<String, RecipesItem>


protocol RecipesListViewType {
    func routetoDetailRecipes(intent: RecipesItem)
    func addRecipes(intent: RecipesItem)
    func editRecipes(intent: RecipesItem)
    func removeRecipes(intent: RecipesItem)
}



typealias RecipesListViewControllerType = UIViewController & RecipesListViewType

