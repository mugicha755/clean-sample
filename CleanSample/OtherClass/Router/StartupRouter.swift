//
//  StartupRouter.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit

class StartupRouter {
    
    /// StartupSequenceにおける画面のルーティング処理
    ///
    /// - Returns: StartupRouterResult
    static func router() -> StartupRouterResult {
        let userDefaults = UserDefaults.standard
        guard let currentStatus = userDefaults.string(forKey: UserDefaultKeyStartupStatus) else {
            return self.defaultView()
        }
        guard let nextView = StartupSequenceStatusViewMap[currentStatus] else {
            return self.defaultView()
        }
        let viewControllerClass = NSClassFromString(nextView) as! UIViewController.Type
        let viewController = viewControllerClass.init()
        return StartupRouterResult(navigationController: UINavigationController(rootViewController: viewController),
                                   viewController: nil)
    }
    
    /// StartupSequenceにおけるデフォルト画面の返却
    ///
    /// - Returns: StartupRouterResult(デフォルト画面)
    private static func defaultView() -> StartupRouterResult {
        let viewController = LoginViewController()
        return StartupRouterResult(navigationController: UINavigationController(rootViewController: viewController),
                                   viewController: nil)
    }
}
