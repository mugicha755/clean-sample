//
//  IDField.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit
import NotAutoLayout
import SVGKit

class IDField: LayoutInfoStoredView {
    private let bg: UIView
    private let icon: UIImageView
    private let iconBg: UIView
    private let inputField: UITextField

    public var textField: UITextField {
        get {
            return self.inputField
        }
    }

    public override init(frame: CGRect) {
        self.bg = UIView()
        self.icon = UIImageView()
        self.iconBg = UIView()
        self.inputField = UITextField()

        super.init(frame: frame)

        setupThisView ()
        setupIcon()
        setupInputField()
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let fittedWidth = self.frame.width
        let fittedHeight = self.frame.height
        return CGSize(width: fittedWidth, height: fittedHeight)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.placeAllComponent()
    }

}

extension IDField {

    private func setupThisView() {
        let component = self.bg
        self.nal.layout(component,
                        with: CGRect(x: 0, y: 0, width: 349, height: 41))
        let maskPath = UIBezierPath(roundedRect: component.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = component.bounds
        maskLayer.path = maskPath.cgPath

        component.layer.mask = maskLayer
        component.backgroundColor = .white
        self.addSubview(component)
    }

    private func setupIcon() {
        let component = self.icon
        let svgImage = SVGKImage(named: "user")
        component.image = svgImage?.uiImage ?? UIImage()
        self.iconBg.addSubview(component)
        self.addSubview(self.iconBg)
    }

    private func setupInputField() {
        let component = self.inputField
        component.keyboardType = .emailAddress
        component.returnKeyType = .next
        self.addSubview(component)
    }

}

extension IDField {

    private func placeAllComponent() {
        self.nal.layout(self.iconBg, by: { $0
            .setTopLeft(by: { $0.topLeft })
            .setWidth(to: 41)
            .setHeight(to: 41)
        })

        self.nal.layout(self.icon, by: { $0
            .setTopLeft(to: .init(x: 9, y:9))
            .setWidth(to: 23)
            .setHeight(to: 23)
        })

        self.nal.layout(self.inputField, by: {$0
            .pinTopLeft(to: self.iconBg, with: {$0.topRight})
            .setWidth(by: {$0.width - 41})
            .setHeight(to: 41)
        })
    }

}
