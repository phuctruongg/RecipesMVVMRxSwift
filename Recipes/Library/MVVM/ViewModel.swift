//
//  ViewModel.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import Foundation
import Foundation
import RxSwift
import RxCocoa

protocol ViewType {
    associatedtype VM: ViewModelType
    var viewModel: VM! { set get }
}
