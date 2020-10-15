//
//  ViewModelType.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType: DisposeBagHolderType, Disposable {
    func transform()
}
