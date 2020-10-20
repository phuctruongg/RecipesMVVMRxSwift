//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//



import RxSwift
import RxCocoa
import RxDataSources
import Swinject

class RecipesViewModel {
    //Output
    public weak var view: RecipesViewType? = nil
    //State
    let didAddRecipe = PublishSubject<Recipe>()
    let didEditRecipe = PublishSubject<Recipe>()
    let didDeleteRecipe = PublishSubject<Void>()
    var recipes: BehaviorRelay<[Recipe]> = .init(value: [])
    var taptoAdd = PublishSubject<Void>()
    var taptoEdit = PublishSubject<Void>()
    var searchBarState = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    //Dependency
    @Injected var recipeRepository: RecipeRepositoryType
    //Presentation
    var listItems: BehaviorRelay<[RecipesCellViewModel]> = .init(value: [])
    var listFilterItems:  BehaviorRelay<[Recipe]> = .init(value: [])
    //transform
    func transform() {
        print("--Inside ViewModel--")
        recipeRepository.getRecipeList()
            .subscribe{ [self] recipe in
                self.recipes.accept(recipe)
            }.disposed(by: disposeBag)
        
        recipes
            .map(mapRecipeListToModel)
            .bind(to: self.listItems)
            .disposed(by: disposeBag)
        
        taptoAdd
            .subscribe(
                onNext: { [weak self] in
                    self?.view?.routeToAddRecipe()
                }
            ).disposed(by: disposeBag)
        
        didAddRecipe
            .subscribe(
                onNext: { [self] value in
                    recipeRepository.addRecipe(value)
                        .bind(onNext: reloadTableView)
                }
            ).disposed(by: disposeBag)
        
        didEditRecipe
            .subscribe(
                onNext: { [self] value in
                    recipeRepository.updateRecipe(value)
                        .bind(onNext: reloadTableView)
                }
            ).disposed(by: disposeBag)
        
        didDeleteRecipe
            .subscribe(
                onNext: { [self] value in
                    reloadTableView()
                }
            ).disposed(by: disposeBag)
        
        searchBarState
            .subscribe(
                onNext: { [self] query in
                    var filterList =  recipes.value.filter{
                        $0.name.hasPrefix(query)
                    }
                   
                    if(filterList.isEmpty){
                        filterList =  recipes.value
                        recipes.accept(filterList)
                    } else {
                        print("sort")
                        recipes.accept(filterList)
                    }
                   
                }
            ).disposed(by: disposeBag)
    }
    
    func reloadTableView(){
        print("reload")
        recipeRepository.getRecipeList()
            .subscribe{ [self] recipe in
                self.recipes.accept(recipe)
            }.disposed(by: disposeBag)
    }
    
    func mapRecipeListToModel(recipeList: [Recipe]) -> [RecipesCellViewModel] {
        
        var listRecipes: [RecipesCellViewModel] = []
        recipeList.map{
            element in
            let item = RecipesCellViewModel.init(recipesThumnail: element.thumnail, recipesDescription: element.description, recipesTitle: element.name, recipesID: element.id)
            listRecipes.append(item)
        }
        return listRecipes
    }
    
}
