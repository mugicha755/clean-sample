//
//  LoginModel.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import ObjectMapper

enum LoginModel {
    /// MARK:
    enum API {
        struct Request {
            var id: String
            var password: String
        }
    }
    
    /// MARK: Display ViewModel
    enum Display {
        struct ViewModel {
            var message: String
        }
    }

}
