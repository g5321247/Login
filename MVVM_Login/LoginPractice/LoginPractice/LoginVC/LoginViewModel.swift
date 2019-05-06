//
//  LoginViewModel.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/26.
//  Copyright © 2018 george.liu. All rights reserved.
//

import Foundation

protocol LoginViewModelInputs {
    func setEmail(_ mail: String?)
    func setPassword(_ password: String?)
    func didTapLogin()
    func didTapGuest()
}

protocol LoginViewModelOutputs {
    var mailCheckingCompletion: ((Bool) -> Void)? { get set }
    var passwordCheckingCompletion: ((Bool) -> Void)? { get set }
    var loginCompletion: ((UserModel) -> Void)? { get set }
}

class LoginViewModel: ViewModelBinding, LoginViewModelInputs, LoginViewModelOutputs {
  
    // MARK: Variable
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    let userManager = UserManager.shared
    private var stringEmail: String?
    private var stringPassword: String?
    
    // MARK: - ViewModelOutputParameter
    var mailCheckingCompletion: ((Bool) -> Void)?
    var passwordCheckingCompletion: ((Bool) -> Void)?
    var loginCompletion: ((UserModel) -> Void)?
    
    // MARK: - ViewModelInputs
    func setEmail(_ mail: String?) {
        stringEmail = mail
    }
    
    func setPassword(_ password: String?) {
        stringPassword = password
    }
    
    func didTapLogin() {
        let emailResult = isValidEmail(stringEmail)
        let passwordResult = isValidPassword(stringPassword)
        
        mailCheckingCompletion?(emailResult)
        passwordCheckingCompletion?(passwordResult)
        
        if emailResult && passwordResult,
            let mail = stringEmail {
            let user = UserModel(userName: "新使用者", emailAddress: mail, isVip: false, birthday: UserModel.getBirthday(), canEdit: true, canPost: true)
            
                userManager.didLoginSuccess(user: user)
                loginCompletion?(userManager.userModel)
        }
    }
    
    func didTapGuest() {
        userManager.didGuestLoginSuccess()
        loginCompletion?(userManager.userModel)
    }    
}

//MARK: - Checkout Information
extension LoginViewModel {
    
    private func isValidEmail(_ mail: String?) -> Bool {
        guard let mail = mail else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: mail)
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        return password.count > 8
    }
}
