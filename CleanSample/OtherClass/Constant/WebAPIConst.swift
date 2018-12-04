//
//  WebAPIConst.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import Alamofire

/// WebAPI HTTP Method
public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

/// APIError Object
public enum APIError: Error {
    case connectionError(NSError)
    case invalidResponse(AnyObject?)
    case parseError(AnyObject?)
    case errorResponse(AnyObject?)
}

let defaultTimeOut = 30.0 as Double

/// WebAPI base URL
let baseRequestURL = "*******************"

/// WebAPI API Path
enum APIPath: String {
    case login = "/login"
}

/// Header field: Auth
enum HeaderFieldKey: String {
    case authorization = "Authorization"
}
