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
        

//    func addRecipe(_ value: Recipe) -> Observable<Void> { }
//    func deleteRecipe(_ value: Recipe) -> Observable<Void> { }
//    func updateRecipe(_ value: Recipe) -> Observable<Void> { }

}
