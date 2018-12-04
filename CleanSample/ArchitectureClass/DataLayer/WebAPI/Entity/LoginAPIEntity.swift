//
//  LoginAPIEntity.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/04.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import ObjectMapper

struct LoginAPIEntity: Mappable {
    var error: String?

    init?(map: Map){
    }

    mutating func mapping(map: Map) {
        error <- map["error"]
    }

}
