//
//  BaseTableViewModelType.swift
//  Recipes
//
//  Created by Apple on 10/15/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol BaseTableViewModelType {
    associatedtype SM : SectionModelType
    associatedtype FM
    //MARK: Input
  
    //MARK: Output
  

}



class BaseTableViewModel<SM, FM> : BaseViewModel, BaseTableViewModelType where SM: SectionModelType {

    
    
    //MARK: Input
    
    //MARK: State -
  
    
    //MARK: Initializer
    required override init() {
        super.init()
    }
    //MARK: Dependency
    
    override func transform() {
        super.transform()
        
        
    }
    
    override func dispose() {
        super.dispose()
      
    }

    
}
