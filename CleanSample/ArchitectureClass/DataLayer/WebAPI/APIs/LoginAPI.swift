//
//  LoginAPI.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import ObjectMapper

struct LoginAPI: Request {

    ///MARK: Protocol
    typealias Response = LoginAPIEntity

    var method: Method {
        return .POST
    }

    var path: APIPath {
        return .login
    }

    var requestModel: LoginModel.API.Request?

    var parameters: [String: AnyObject] {
        return ["id": requestModel?.id as AnyObject, "password": requestModel?.password as AnyObject]
    }

    func responseToEntity(object: AnyObject, URLResponse: HTTPURLResponse) -> Response? {
        guard let entity = Mapper<Response>().map(JSONObject: object) else {
            return nil
        }
        return entity
    }

}
