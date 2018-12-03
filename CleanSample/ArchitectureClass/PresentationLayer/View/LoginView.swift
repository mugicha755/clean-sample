//
//  LoginView.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/11/30.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit
import NotAutoLayout

private let padding: NotAutoLayout.Float = 13
private let topMargin: NotAutoLayout.Float = 20
private let cornerRadius = 10

class LoginView: LayoutInfoStoredView {
    private let imageView: UIImageView
    private let mainTitleLabel: UILabel
    private let subTitleLabel: UILabel
    private let passwordTextField: PasswordField
    private let idTextField: IDField
    private let submitButton: UIButton
    private let signUpButton: UIButton

    public var titleAttribute: NSAttributedString? {
        get {
            return self.subTitleLabel.attributedText
        }
        set {
            self.subTitleLabel.attributedText = newValue
        }
    }

    public var mainImage: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }

    public var mainTitle: String? {
        get {
            return self.mainTitleLabel.text
        }
        set {
            self.mainTitleLabel.text = newValue
        }
    }

    public var subTitle: String? {
        get {
            return self.subTitleLabel.text
        }
        set {
            self.subTitleLabel.text = newValue
        }
    }

    public var submit: UIButton? {
        get {
            return self.submitButton
        }
    }

    public var passwordField: PasswordField {
        get {
            return self.passwordTextField
        }
    }

    public var idField: IDField {
        get {
            return self.idTextField
        }
    }

    public override init(frame: CGRect) {
        // initialize ui item
        self.imageView = UIImageView()
        self.mainTitleLabel = UILabel()
        self.subTitleLabel = UILabel()
        self.submitButton = UIButton()
        self.signUpButton = UIButton()
        self.passwordTextField = PasswordField()
        self.idTextField = IDField()

        super.init(frame: frame)

        self.backgroundColor = UIColor(hex: Color.ColorCode.applicationThema.rawValue)

        self.setupImageView()
        self.setupIdField()
        self.setupSignUpButton()
        self.setupSubmitButton()
        self.setupPasswordField()
        self.setupSubTitleLabel()
        self.setupMainTitleLabel()
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

extension LoginView {

    private func setupImageView() {
        let component = self.imageView
        component.contentMode = .scaleAspectFit
        self.addSubview(component)
    }

    private func setupMainTitleLabel() {
        let component = self.mainTitleLabel
        component.clipsToBounds = true
        component.numberOfLines = 0
        component.font = .systemFont(ofSize: 16)
        component.textColor = UIColor(hex: Color.ColorCode.fontThema.rawValue)
        self.addSubview(component)
    }

    private func setupSubTitleLabel() {
        let component = self.subTitleLabel
        component.clipsToBounds = true
        component.numberOfLines = 0
        component.font = .systemFont(ofSize: 13)
        component.textColor = UIColor(hex: Color.ColorCode.fontThema.rawValue)
        component.textColor = .black
        self.addSubview(component)
    }

    private func setupIdField() {
        let component = self.idTextField
        component.backgroundColor = UIColor.clear
        self.addSubview(component)
    }

    private func setupPasswordField() {
        let compnent = self.passwordTextField
        compnent.backgroundColor = UIColor.clear
        self.addSubview(compnent)
    }

    private func setupSubmitButton() {
        let component = self.submitButton
        component.layer.cornerRadius = 15
        component.titleLabel?.font = .systemFont(ofSize: 16)
        component.setTitle("Sign in", for: .normal)
        component.backgroundColor = UIColor(hex: Color.ColorCode.buttonThema.rawValue)
        self.addSubview(component)
    }

    private func setupSignUpButton() {
        let component = self.submitButton
        component.layer.cornerRadius = 10
        self.addSubview(component)

    }

}

extension LoginView {

    private func placeAllComponent() {
        self.nal.layout(self.imageView, by: {$0
            .setTopCenter(by: {$0.topCenter})
            .setWidth(by: {$0.height * 0.2})
            .setHeight(by: {$0.height * 0.2})
            .movingY(by: topMargin)
        })

        self.nal.layout(self.mainTitleLabel, by: {$0
            .pinTopCenter(to: self.imageView, with: { $0.bottomCenter })
            .setWidth(by: {$0.width - padding*2})
            .fitHeight()
            .movingY(by: padding)
            .movingLeft(to: padding)
        })

        self.nal.layout(self.subTitleLabel, by: {$0
            .pinTopCenter(to: self.mainTitleLabel, with: { $0.bottomCenter })
            .setWidth(by: {$0.width - padding*2})
            .fitHeight()
            .movingLeft(to: padding)
            .movingY(by: padding)
        })

        self.nal.layout(self.idTextField, by: {$0
            .pinTopCenter(to: self.subTitleLabel, with: { $0.bottomCenter })
            .setWidth(by: {$0.width - padding*2})
            .setHeight(to: 41)
            .movingLeft(to: padding)
            .movingY(by: padding)
        })

        self.nal.layout(self.passwordTextField, by: {$0
            .pinTopCenter(to: self.idTextField, with: { $0.bottomCenter })
            .setWidth(by: {$0.width - padding*2})
            .setHeight(to: 41)
            .movingLeft(to: padding)
            .movingY(by: 1)
        })

        self.nal.layout(self.submitButton, by: {$0
            .pinTopCenter(to: self.passwordTextField, with: { $0.bottomCenter })
            .setWidth(by: {$0.width - padding * 8})
            .setHeight(to: 50)
            .movingLeft(to: padding * 4)
            .movingY(by: padding * 2)
        })

        self.nal.layout(self.signUpButton, by: {$0
            .pinTopCenter(to: self.submitButton, with: { $0.bottomCenter })
            .setWidth(by: {$0.width})
            .setHeight(to: 50)
        })

    }

}
