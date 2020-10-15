//
//  RecipeRepository.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//

import Foundation
import RxCocoa
import RxSwift
class RecipeRepository {
    
    func getRecipeList() -> Observable<[Recipe]> {
        print("set a vaiable to recipe")
        guard let path = Bundle.main.path(forResource: "recipesList", ofType: "json") else {
            // return empty when can't found a mock data file
            return Observable.just([])
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let recipe = try JSONDecoder().decode([Recipe].self, from: data)
            return Observable.just(recipe)
        }
        catch{
            print("error")
        }
        return Observable.just([])
    }
    
    func mapRecipeListToModel(recipeList: BehaviorRelay<[Recipe]>) -> Observable<[RecipesCellViewModel]> {
        print("mapping recipe")
        var listRecipes: [RecipesCellViewModel] = []
        recipeList.value.map{
            element in
            let item = RecipesCellViewModel.init(recipesThumnail: element.thumnail, recipesDescription: element.description, recipesTitle: element.name)
            listRecipes.append(item)
        }
        return Observable.just(listRecipes)
    }
        
    
//    func addRecipe(_ value: Recipe) -> Observable<Void> { }
//    func deleteRecipe(_ value: Recipe) -> Observable<Void> { }
//    func updateRecipe(_ value: Recipe) -> Observable<Void> { }

}
