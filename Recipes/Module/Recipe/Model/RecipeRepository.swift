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
    
    func addRecipe(_ value: Recipe, list: BehaviorRelay<[Recipe]>) -> Observable<Void> {
        var currentList = list.value
        currentList.append(value)
        list.accept(currentList)
        return Observable.just(())
    }
//    func deleteRecipe(_ value: Recipe) -> Observable<Void> { }
//    func updateRecipe(_ value: Recipe) -> Observable<Void> { }

}
