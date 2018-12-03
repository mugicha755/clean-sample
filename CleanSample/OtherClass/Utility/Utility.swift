//
//  Utility.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit

internal struct Color {
    enum ColorCode: String {
        case applicationThema = "fff0f2"
        case buttonThema = "ffa1a7"
        case FontThema = "413a3e"
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        if hex.count == 6 {
            let rawValue: Int = Int(hex, radix: 16) ?? 0
            let blue: Int = rawValue % 256
            let green: Int = ((rawValue - blue) / 256) % 256
            let red: Int = ((rawValue - blue) / 256 - green) / 256

            self.init(red: CGFloat(red) / 255,
                      green: CGFloat(green) / 255,
                      blue: CGFloat(blue) / 255,
                      alpha: alpha)
        } else {
            /// this is error case.
            /// return default-color.
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}
