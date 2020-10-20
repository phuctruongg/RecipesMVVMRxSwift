//
//  RecipeAddViewController.swift
//  Recipes
//
//  Created by Apple on 10/16/20.
//


import Foundation
import RxSwift
import RxCocoa

class RecipeAddViewController: UIViewController, RecipeAddViewType  {
   
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextView!
  
    var pos: String!
    var addRecipe = PublishSubject<Recipe>()
    var viewModel: RecipeAddViewModel?
    let disposeBag = DisposeBag()
    let didAddRecipe = PublishSubject<Recipe>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecipeAddViewModel()
        bindSetup()
        viewModel!.transform()
        viewModel?.view = self
    }
    
    func bindSetup(){
        descriptionTextField.rx.text
            .orEmpty
            .bind(to: viewModel!.descriptiontitleTextField)
            .disposed(by: disposeBag)

        titleTextField.rx.text
            .orEmpty
            .bind(to: viewModel!.titleTextField)
            .disposed(by: disposeBag)

        saveButton.rx.tap.asObservable()
            .bind(to: viewModel!.submitButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel?.isAdded.asObservable()
        .skip(1)
            .subscribe{ [self]
            isAdd in
            if(isAdd.element!){
                self.showAlert(title: "Notification", message: "Add New Recipe Successfully")
            } else {
                self.showFailAlert(title: "Error", message: "All field must be fill")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func showAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self]_ in
            _ = self.navigationController?.popViewController(animated: true)
            self.addRecipe.onNext( Recipe.init(recipesThumnail: "pizza", recipesDescription: self.descriptionTextField.text!, recipesTitle: self.titleTextField.text!,id: pos))
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showFailAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
        
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


