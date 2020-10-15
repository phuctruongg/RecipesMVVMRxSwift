//
//  BaseTableViewController.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//


import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class BaseTableViewController<VM>: BaseViewController<VM> where VM: (BaseViewModel&BaseTableViewModelType) {
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    var disposeBag : DisposeBag!
    
    //State
    let dataSource = RxTableViewSectionedReloadDataSource<RecipesSection>(
      configureCell: { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesListTableViewCell", for: indexPath) as! RecipesListTableViewCell
        return cell
    })
    
    //MARK: View Cycle
    override func loadView() {
        super.loadView()
        print("base view controller")
//initializing viewModel in subclass
//        viewModel ??= VM()
//        viewModel.disposed(by: disposeBag)
    }
  
    //MARK: setupView
    override func setupView() {
        super.setupView()
        setupTableView()
    }
    
    func setupTableView() {
        
    }
    
    //MARK: setupTransformInput
    override func setupTransformInput() {
        super.setupTransformInput()
      
    }
    
    //MARK: subscribe
    override func subscribe() {
        super.subscribe()
    
    }
}


