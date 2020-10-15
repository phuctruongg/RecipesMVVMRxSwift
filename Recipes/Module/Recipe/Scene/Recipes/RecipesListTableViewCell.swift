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
    
    @IBOutlet weak var cardView: UIStackView!
    @IBOutlet var recipesTitle: UILabel!
    @IBOutlet var recipesDescription: UILabel!
    @IBOutlet var recipesImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var viewModel: RecipesCellViewModel? {
        didSet {
            if let viewModel = viewModel {
//                recipesTitle.text = viewModel.recipesTitle
//                let imageURL = URL(string: viewModel.recipesThumnail ?? "")
//                let data = try? Data(contentsOf: imageURL!)
//                recipesImage.image = UIImage(data: data!)
            }
        }
    }
}



extension Reactive where Base : RecipesListTableViewCell {
    var didTap: Driver<RecipesCellViewModel> {
        return base.cardView.rx.tapGesture().when(.recognized).asVoid().asDriverOnErrorJustComplete().map { _ in self.base.viewModel! }
    }
}




extension Observable {
    func asVoid() -> Observable<Void> {
        return self.map { _ in () }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            //assertionFailure()
            return Driver.empty()
        }
    }
    
}

