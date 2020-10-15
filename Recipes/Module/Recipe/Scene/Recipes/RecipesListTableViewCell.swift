//
//  ListRecipesTableViewCell.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class RecipesListTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var cardView: UIStackView!
    @IBOutlet var recipesTitle: UILabel!
    @IBOutlet var recipesDescription: UILabel!
    @IBOutlet var recipesImage: UIImageView!
    
    
    var viewModel: RecipesCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                recipesTitle.text = viewModel.recipesTitle
                recipesDescription.text = viewModel.recipesDescription
                recipesImage.image=UIImage(named: viewModel.recipesThumnail!)
            }
        }
    }
    
    func subsrice(){
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subsrice()
        self.backgroundColor = .clear
    }

    
}



extension Reactive where Base : RecipesListTableViewCell {
   
}

