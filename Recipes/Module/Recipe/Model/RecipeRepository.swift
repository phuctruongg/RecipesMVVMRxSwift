//
//  RecipeRepository.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//

import Foundation
import RxCocoa
import RxSwift
class RecipeRepository : RecipeRepositoryType {
    
    func getRecipeList() -> Observable<[Recipe]> {
        guard let path = Bundle.main.path(forResource: "recipesList", ofType: "json") else {
            // return empty when can't found a mock data file
            return Observable.just([])
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), options: .mappedIfSafe)
            let recipe = try JSONDecoder().decode([Recipe].self, from: data)
            print(recipe)
            return Observable.just(recipe)
        }
        catch{
            print("error")
        }
        return Observable.just([])
    }
    
    func addRecipe(_ value: Recipe) -> Observable<Void>{
        guard let path = Bundle.main.path(forResource: "recipesList", ofType: "json") else {
            // return empty when can't found a mock data file
            return Observable.just(())
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), options: .mappedIfSafe)
            var recipe = try JSONDecoder().decode([Recipe].self, from: data)
            recipe.append(value)
            writeToFile(location: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), recipeList: recipe)
           
            print("write json file")
            return Observable.just(())
        }
        catch{
            print("error")
        }
        return Observable.just(())
    }
    func deleteRecipe(_ value: Recipe) -> Observable<Void> {
        guard let path = Bundle.main.path(forResource: "recipesList", ofType: "json") else {
            // return empty when can't found a mock data file
            return Observable.just(())
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), options: .mappedIfSafe)
            var recipe = try JSONDecoder().decode([Recipe].self, from: data)
            let index = recipe.index(where: { (item) -> Bool in
                item.id == value.id
            })
            recipe.remove(at: index!)
            writeToFile(location: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), recipeList: recipe)
            return Observable.just(())
        }
        catch{
            print("error")
        }
        return Observable.just(())
    }
    func updateRecipe(_ value: Recipe) -> Observable<Void> {
        guard let path = Bundle.main.path(forResource: "recipesList", ofType: "json") else {
            // return empty when can't found a mock data file
            return Observable.just(())
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), options: .mappedIfSafe)
            var recipe = try JSONDecoder().decode([Recipe].self, from: data)
            
            let index = recipe.index(where: { (item) -> Bool in
                item.id == value.id
            })
            recipe[index!] = value
           
            writeToFile(location: URL(fileURLWithPath: "/Users/apple/Desktop/SwiftLearn/RecipesMVVMRxSwift/Recipes/recipesList.json"), recipeList: recipe)
            return Observable.just(())
        }
        catch{
            print("error")
        }
        return Observable.just(())
    }
 
}

protocol RecipeRepositoryType {
    func getRecipeList() -> Observable<[Recipe]>
    func addRecipe(_ value: Recipe) -> Observable<Void>
    func deleteRecipe(_ value: Recipe) -> Observable<Void>
    func updateRecipe(_ value: Recipe) -> Observable<Void>
}

func writeToFile(location: URL, recipeList: [Recipe]) {
    do{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let JsonData = try encoder.encode(recipeList)
        try JsonData.write(to: location)
    }catch{
        print(error)
    }
}
