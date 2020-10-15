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
        print("hi")
        viewmodel.transform()
        bindTableView()
    }
    
    func bindTableView() {
        tableView.register(UINib(nibName: "RecipesListTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipesListTableViewCell")
        viewmodel.recipes.bind(to: tableView.rx.items(cellIdentifier: "RecipesListTableViewCell")) { index, model, cell in
            var cells = cell as! RecipesListTableViewCell
            cells.recipesDescription.text = model.description
            cells.recipesTitle.text = model.name
            cells.recipesImage.image=UIImage(named: model.thumnail)
        }
        .disposed(by: disposeBag)
    }
}

class ImageLoader {

  private static let cache = NSCache<NSString, NSData>()

  class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {

    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {

      if let data = self.cache.object(forKey: url.absoluteString as NSString) {
        DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        return
      }

      guard let data = NSData(contentsOf: url) else {
        DispatchQueue.main.async { completionHandler(nil) }
        return
      }

      self.cache.setObject(data, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
    }
  }

}
