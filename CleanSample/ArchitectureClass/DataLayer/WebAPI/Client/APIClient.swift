//
//  APIClient.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import Alamofire
import Hydra

class APIClient {

    var sessionManager: SessionManager?

    /// WebAPIのClient処理
    func request<T: Request>(request: T) -> Promise<T.Response> {

        let promise = Promise<T.Response> { resolve, reject, _ in
            self.createRequest(request: request)?.validate { _, response, _ in
                /// pass 200~299, other value is failure
                if 200..<300 ~= response.statusCode {
                    return .success
                }
                return .failure(APIError.InvalidResponse(response as AnyObject))
            }
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { _ in
                /// WebAPI request progress
            }
            .responseJSON(completionHandler: { response in
                guard case let .failure(error) = response.result else {
                    if let object = response.result.value, let URLResponse = response.response {
                        guard let entity = request.responseToEntity(object: object as AnyObject, URLResponse: URLResponse) else {
                            reject(APIError.ParseError(object as AnyObject))
                            return
                        }
                        resolve(entity)
                    } else {
                        reject(APIError.InvalidResponse(nil))
                    }
                    return
                }
                /// this error is AFError or URLError or Unknown error
                reject(error as NSError)
            })
        }
        return promise
    }

    /// Alamofire用のDataRequestオブジェクトを生成
    private func createRequest<T: Request>(request: T) -> DataRequest? {
        do {
            let uri = (request.baseURL.absoluteString! + request.path.rawValue + (request.option ?? "") ) as String
            let params = request.parameters.count == 0 ? nil : request.parameters
            /// header連結
            let headers = (["content-type": "application/json"]).merging(request.HTTPHeaderFields, uniquingKeysWith: +)
            let method = Alamofire.HTTPMethod(rawValue: request.method.rawValue)
            let encoding = JSONEncoding.default

            var urlRequest = try URLRequest(url: uri, method: method!, headers: headers)
            /// no-cache
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
            urlRequest.timeoutInterval = request.timeoutInterval
            let encodedURLRequest = try encoding.encode(urlRequest, with: params)
            sessionManager = SessionManager.default

            return sessionManager?.request(encodedURLRequest)
        } catch {
            return nil
        }
    }

}
