//
//  PresentErrorProtocol.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//


import RxSwift
import RxCocoa

@objc protocol PresentErrorProtocol: class {
    func present(error: Error, completion: @escaping ()->())
}
