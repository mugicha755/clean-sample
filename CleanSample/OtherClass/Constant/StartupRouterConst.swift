//
//  StartupRouterConst.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit

let UserDefaultKeyStartupStatus: String = "ud_key_startup"

enum StartupSequenceStatus: String {
    case initial = "Initial"
    case finishAuthentication = "FinishAuthentication"
}

enum StartupSequenceDisplayView: String {
    case authentication = "CleanSample.UserAuthenticationViewController"
    case daily = "CleanSample.DailyRecordViewController"
}

let StartupSequenceStatusViewMap: [String:String] = [
    StartupSequenceStatus.initial.rawValue: StartupSequenceDisplayView.authentication.rawValue,
    StartupSequenceStatus.finishAuthentication.rawValue: StartupSequenceDisplayView.daily.rawValue
]

struct StartupRouterResult {
    /// NavigationController以外を返却する場合は, 追加する.
    var navigationController: UINavigationController?
    var viewController: UIViewController?
}
