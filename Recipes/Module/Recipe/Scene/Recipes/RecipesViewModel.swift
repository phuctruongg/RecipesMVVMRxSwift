//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//



import RxSwift
import RxCocoa
import RxDataSources

class RecipesViewModel {
    //State
    var recipes: BehaviorRelay<[Recipe]> = .init(value: [])
    private let disposeBag = DisposeBag()
    //Dependency
    let recipeRepository = RecipeRepository()
    //Presentation
    var listItems: BehaviorRelay<[RecipesCellViewModel]> = .init(value: [])
    //transform
    func transform() {
        print("--Inside ViewModel--")
        //read list of recipe from RecipeRepository
        //and set it to varible 'recipe'
        recipeRepository.getRecipeList()
            .subscribe{ [self] recipe in
                self.recipes.accept(recipe)
            }.disposed(by: disposeBag)
        self.recipes
            .map(mapRecipeListToModel)
            .bind(to: self.listItems)
            .disposed(by: disposeBag)
        
        
        
        
        //setup changes from variable 'recipe' and map it into 'listItems'
    }
    
    func mapRecipeListToModel(recipeList: [Recipe]) -> [RecipesCellViewModel] {
        var listRecipes: [RecipesCellViewModel] = []
        print("mapping")
        recipeList.map{
            element in
            let item = RecipesCellViewModel.init(recipesThumnail: element.thumnail, recipesDescription: element.description, recipesTitle: element.name, recipesID: element.id)
            listRecipes.append(item)
        }
      return listRecipes
    }
    
}
