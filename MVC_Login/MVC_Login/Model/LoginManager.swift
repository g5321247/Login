//
//  LoginManager.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/7.
//  Copyright © 2019 George Liu. All rights reserved.
//

import Foundation

class LoginManager {
    
    func checkInput(mail: String?, password: String?, success: @escaping () -> Void ,failure: @escaping (Bool, Bool) -> Void) {
        let validMail = isValidEmail(mail)
        let validPassword = isValidPassword(password)
        
        guard validMail && validPassword else {
            failure(validMail, validPassword)
            return
        }
        success()
    }
    
}

private extension LoginManager {
    
    func isValidEmail(_ mail: String?) -> Bool {
        guard let mail = mail else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: mail)
    }
    
    func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        return password.count > 8
    }
    
}
