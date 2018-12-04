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

protocol LoginDisplayLogic: class {
    func didAuthentication(_ model: LoginModel.Display.ViewModel)
}

class LoginViewController: UIViewController {

    private var interactor: LoginBusinessLogic?

    /// MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

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
        let view = self.view as! LoginView
        let request =  LoginModel.API.Request(id: view.idField.textField.text!,
                                              password: view.passwordField.textField.text!)
        interactor?.doLogin(request)
    }

    /// MARK: Private method
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

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

extension LoginViewController: LoginDisplayLogic {
    func didAuthentication(_ model: LoginModel.Display.ViewModel) {
        let alert: UIAlertController = UIAlertController(
            title: "Login result",
            message: model.message,
            preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

}
