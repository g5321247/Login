//
//  LoginView.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/7.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func checkInfo(mail: String?, password: String?)
}

struct LoginViewObject {
    let isValidMail: Bool
    let isValidPassword: Bool
}

class LoginView: UIView {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    
    weak var delegate: LoginViewDelegate?
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        delegate?.checkInfo(mail: tfEmail.text, password: tfPassword.text)
    }
    
    func updateView(object: LoginViewObject) {
        llEmailError.isHidden = object.isValidMail
        llPasswordError.isHidden = object.isValidPassword
        
    }
    
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
