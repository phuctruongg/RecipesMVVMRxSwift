//
//  RecipeDetailViewModel.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//

//

import Foundation
import RxSwift
import RxCocoa

class RecipeAddViewModel {
    
    let submitButtonTapped = PublishSubject<Void>()
    var image = BehaviorRelay<String>(value: "")
    var titleTextField = BehaviorRelay<String>(value: "")
    var descriptiontitleTextField = BehaviorRelay<String>(value: "")
    var isAdded = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    var view = RecipeAddViewController()
    
    
    
    func transform() {
        print("--Inside ViewModel--")
        submitButtonTapped
            .subscribe(
                onNext: { [weak self] in
                    if(!self!.titleTextField.value.isEmpty){
                        self!.isAdded.accept(true)
                    } else {
                        self!.isAdded.accept(false)
                    }
                }
        ).disposed(by: disposeBag)
    
        titleTextField
            .subscribe(
                onNext: { content in}
        ).disposed(by: disposeBag)
        
        descriptiontitleTextField
            .subscribe(
                onNext: { content in}
        ).disposed(by: disposeBag)
    }
}
