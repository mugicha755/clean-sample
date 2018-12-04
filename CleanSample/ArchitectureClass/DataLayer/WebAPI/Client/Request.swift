//
//  Request.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//
import ObjectMapper

protocol Request {
    associatedtype Response

    var baseURL: NSURL { get }
    var method: Method { get }
    var path: APIPath { get }
    var parameters: [String: AnyObject] { get }
    var option: String? {get}
    var HTTPHeaderFields: [String: String] { get }
    var timeoutInterval: Double {get}

    func responseToEntity(object: AnyObject, URLResponse: HTTPURLResponse) -> Response?
}

/// MARK: - Request
extension Request {

    var baseURL: NSURL {
        return NSURL(string: baseRequestURL)!
    }

    var HTTPHeaderFields: [String: String] {
        return [:]
    }

    var parameters: [String: AnyObject] {
        return [:]
    }

    var option: String? {
        return nil
    }

    var timeoutInterval: Double {
        return defaultTimeOut
    }

}

/// MARK: - Response: Mappable
extension Request where Response: Mappable {

    func responseToEntity(object: AnyObject, URLResponse: HTTPURLResponse) -> Response? {
        guard let entity = Mapper<Response>().map(JSONObject: object) else {
            return nil
        }
        return entity
    }

}
