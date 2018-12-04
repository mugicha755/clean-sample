//
//  LoginUseCase.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import Hydra

class LoginUseCase {

    var interactor: LoginAPIResultLogic?

    func executeAuthentication(_ request: LoginModel.API.Request) {
        LoginAPIRepository().login(request)
        .then { result in
            self.interactor?.didLogin(LoginModel.Display.ViewModel(message: "succeed !!!"))
        }.catch() { error in
            self.interactor?.didLogin(error)
        }
    }

}
