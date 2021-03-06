//
//  App+DI.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Swinject
import UIKit


struct DI {
    static let container = Container()
}

extension UIStoryboard {
    func instantiateViewController<T>(withIdentifier identifier: String) -> T {
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension DI {
    static func registerViewController<T>(storyboard: UIStoryboard, type:T.Type, identifier: String) {
        DI.container.register(T.self) { r -> T in
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
    }
}

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    public var container: Resolver?
    //public var name: String?
    public var wrappedValue: Service {
        mutating get {
            if service == nil {
                service = DI.container.resolve(Service.self)
            }
            return service!
        }
        mutating set {
            service = newValue
        }
    }
}
