//
//  ViewController.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import UIKit
import RxSwift
import RxCocoa

class RecipesViewController: UIViewController {
    //MARK:- Outlet
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //MARK:- DisposeBag
    private let disposeBag = DisposeBag()
    
    var viewmodel = RecipesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.transform()
        viewmodel.view = self
        bindTableView()
        self.title = "List Recipe"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func bindTableView() {
        tableView.dataSource = nil
        tableView.register(UINib(nibName: "RecipesListTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipesListTableViewCell")
        // Catch event when select
        tableView.rx.modelSelected(RecipesCellViewModel.self)
            .subscribe(onNext: { [weak self] recipe in
                guard let self = self else { return }
                self.routeToRecipeDetail(recipe: Recipe.init(recipesThumnail: recipe.recipesThumnail!, recipesDescription: recipe.recipesDescription!, recipesTitle: recipe.recipesTitle!, id: recipe.recipesID!))
            }).disposed(by: disposeBag)
        // Loading list item
        viewmodel.listItems.bind(to: tableView.rx.items(cellIdentifier: "RecipesListTableViewCell")) { index, model, cell in
            let cells = cell as! RecipesListTableViewCell
            cells.viewModel = model
        }
        .disposed(by: disposeBag)
        // add new item
        addButton.rx.tap.asObservable()
            .bind(to: viewmodel.taptoAdd)
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .changed
            .asObservable()
            .filter { !$0.isEmpty }
            .bind(to: viewmodel.searchBarState)
            .disposed(by: disposeBag)
            
        
            
            
            
    }
}

extension RecipesViewController: RecipesViewType {
    func routeToRecipeDetail(recipe: Recipe) {
        let screen = DI.container.resolve(RecipesDetailViewControllerType.self)!
        screen.editRecipe.bind(to: viewmodel.didEditRecipe)
        screen.deleteRecipe.bind(to: viewmodel.didDeleteRecipe)
        screen.recipeIntent = recipe
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    func routeToAddRecipe() {
        let screen = DI.container.resolve(RecipesAddViewControllerType.self)!
        screen.didAddRecipe.bind(to: viewmodel.didAddRecipe)
        screen.pos = String(tableView.visibleCells.count)
        self.navigationController?.pushViewController(screen, animated: true)
    }
    
    
    
}

