//
//  DisposeBagHolderType.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import RxSwift

protocol DisposeBagHolderType: class {
    var disposeBag:DisposeBag { set get }
}
