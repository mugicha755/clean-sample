//
//  LoginAPIRepository.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import Hydra

public class LoginAPIRepository {
    func login(_ parameter: LoginModel.API.Request) -> Promise<LoginAPIEntity> {
        let promise = Promise<LoginAPIEntity> { resolve, reject, _ in
            var request = LoginAPI()
            request.requestModel = parameter
            APIClient().request(request: request)
                .then { result in
                    resolve(result)
                }
                .catch { error in
                    reject(error)
            }
        }
        return promise
    }

}
