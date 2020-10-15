//
//  ErrorHandlingViewModelType.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//


import RxSwift
import RxCocoa

struct ErrorHandlingInput {
    weak var view:ErrorHandlingViewType?
    let error:Driver<NSError>
    
    static func none() -> ErrorHandlingInput {
        return ErrorHandlingInput(view: nil, error: .never())
    }
    init(view: ErrorHandlingViewType? = nil, error: Driver<NSError> = .never()) {
        self.view = view
        self.error = error
    }
}
struct ErrorHandlingOutput {
    var showError:Driver<NSError>
    var showLoginSessionExpire:Driver<Void>
    var showOtherError:Driver<NSError>
    init(showError:Driver<NSError> = .never(),
         showLoginSessionExpire:Driver<Void> = .never(),
         showOtherError:Driver<NSError> = .never()) {
        self.showError = showError
        self.showLoginSessionExpire = showLoginSessionExpire
        self.showOtherError = showOtherError
    }
    static func none() -> ErrorHandlingOutput {
        return ErrorHandlingOutput()
    }
}
protocol ErrorHandlingViewModelType: DisposeBagHolderType {
    func transformErrorHandling(input:ErrorHandlingInput) -> ErrorHandlingOutput
}
