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
    
    @IBOutlet weak var tableView: UITableView!
    //
    private let disposeBag = DisposeBag()
    var viewmodel = RecipesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.transform()
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
        tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
            let cell = self?.tableView.cellForRow(at: indexPath) as? RecipesListTableViewCell
            self!.routeToDetail(intent: cell!)
          }).disposed(by: disposeBag)
        // Loading list item
        viewmodel.listItems.bind(to: tableView.rx.items(cellIdentifier: "RecipesListTableViewCell")) { index, model, cell in
            let cells = cell as! RecipesListTableViewCell
            cells.viewModel = model
        }
        .disposed(by: disposeBag)
    }
    
    func routeToDetail(intent : RecipesListTableViewCell){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! RecipeDetailViewController
        vc.recipeIntent = intent
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
