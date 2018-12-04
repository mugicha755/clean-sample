//
//  LoginInteractor.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import Hydra
import UIKit

protocol LoginBusinessLogic {
    func doLogin(_ request: LoginModel.API.Request)
}

protocol LoginAPIResultLogic {
    func didLogin(_ response: LoginModel.Display.ViewModel)
    func didLogin(_ error: Error)
}

class LoginInteractor: LoginBusinessLogic {
    var presenter: LoginPresenter?
    var useCase: LoginUseCase?
    var isWorking: Bool = false

    /// MARK: BusinessLogic
    func doLogin(_ request: LoginModel.API.Request) {
        if !self.isWorking {
            self.useCase = self.useCase ?? LoginUseCase()
            self.useCase?.interactor = self
            self.useCase?.executeAuthentication(request)
            self.isWorking = true
        }
    }
    
}

extension LoginInteractor: LoginAPIResultLogic {
    func didLogin(_ model: LoginModel.Display.ViewModel) {
        async(in: .main) {
            self.presenter?.presentAuthentication(model)
            self.isWorking = false
        }
    }

    func didLogin(_ error: Error) {
        async(in: .main) {
            self.presenter?.presentAuthentication(
                LoginModel.Display.ViewModel(message: "error: Not-found")
            )
            self.isWorking = false
        }
    }

}
