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
        recipeRepository.mapRecipeListToModel(recipeList: recipes)
            .subscribe{
                [self] element in
                listItems.accept(element)
            }.disposed(by: disposeBag)
            
        
      
        //setup changes from variable 'recipe' and map it into 'listItems'
    }

}
