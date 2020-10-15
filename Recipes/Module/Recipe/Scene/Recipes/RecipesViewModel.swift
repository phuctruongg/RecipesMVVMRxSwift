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
    var listItems: BehaviorRelay<[RecipesCellViewModel]> = .init(value: [])
    //Dependency
    let recipeRepository = RecipeRepository()
    //DisposeBag
    private let disposeBag = DisposeBag()
    //
    //transform
    func transform() {
        print("--Inside ViewModel--")
        //read list of recipe from RecipeRepository
        //and set it to varible 'recipe'
        recipeRepository.getRecipeList().subscribe{ [self] event in
            self.recipes.accept(event)
           
          }
        //setup changes from variable 'recipe' and map it into 'listItems'
    }
    
    
    
    
}
