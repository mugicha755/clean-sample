//
//  LoginViewController.swift
//  CleanSample
//
//  Created by mugicha755 on 2018/12/03.
//  Copyright © 2018 mugicha755. All rights reserved.
//

import UIKit
import Hydra
import SVGKit

class LoginViewController: UIViewController {

    /// MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDisplayComponent()
    }

    /// MARK: Button touch event
    @objc func touchDownButton(sender: UIButton) {
        sender.backgroundColor = UIColor(hex: Color.ColorCode.buttonThema.rawValue,
                                         alpha: 0.5)
    }

    @objc func touchCancel(sender: UIButton) {
        sender.backgroundColor = UIColor(hex: Color.ColorCode.buttonThema.rawValue)
    }

    @objc func touchUpAuthChallenge(sender: UIButton) {
        sender.backgroundColor = UIColor(hex: Color.ColorCode.buttonThema.rawValue)
    }

    /// MARK: Private method
    private func setupDisplayComponent() {
        let content = LoginView(frame: self.view.frame)
        content.mainTitle = "Sign in"
        content.mainImage = UIImage(named: "logo.png") ?? UIImage()
        content.submit?.addTarget(self, action: #selector(touchUpAuthChallenge(sender:)), for: .touchUpInside)
        content.submit?.addTarget(self, action: #selector(touchDownButton(sender:)), for: .touchDown)
        content.submit?.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchUpOutside)
        content.submit?.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchCancel)
        content.submit?.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchDragExit)

        content.idField.textField.delegate = self
        content.passwordField.textField.delegate = self

        self.view = content

    }

}

extension LoginViewController: UITextFieldDelegate {

    /// MARK: text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            guard let view: LoginView = self.view as? LoginView else {
                return true
            }
            view.passwordField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true

    }

}
