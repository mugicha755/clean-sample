//
//  LoginPresenter.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
    func presentAuthentication(_ model: LoginModel.Display.ViewModel)
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    /// MARK: do authentication
    func presentAuthentication(_ model: LoginModel.Display.ViewModel) {
        viewController?.didAuthentication(model)
    }

}
