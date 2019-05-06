//
//  LoginWithRXViewModel.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/3.
//  Copyright © 2019 george.liu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginWithRXViewModelInputs {
    var emailSubject: BehaviorSubject<String?> { get }
    var passwordSubject: BehaviorSubject<String?> { get }
    func didTapLogin()
    func didTapGuest()
}

protocol LoginWithRXViewModelOutputs {
    var mailChecking: Driver<Bool> { get }
    var passwordChecking: Driver<Bool> { get }
    var login: Driver<Void> { get }
}

class LoginWithRXViewModel: ViewModelBinding, LoginWithRXViewModelInputs, LoginWithRXViewModelOutputs {
    
    var inputs: LoginWithRXViewModelInputs { return self }
    var outputs: LoginWithRXViewModelOutputs { return self }
    
    // MARK: - ViewModelInputParameter
    var emailSubject: BehaviorSubject<String?>
    var passwordSubject: BehaviorSubject<String?>
    
    // MARK: - ViewModelOutputParameter
    var mailChecking: Driver<Bool>
    var passwordChecking: Driver<Bool>
    var login: Driver<Void>
    
    // MARK: PrivateVariable
    private let userManager = UserManager.shared
    private let mailCheckingSubject: PublishSubject<Bool> = PublishSubject()
    private let passwordCheckingSubject: PublishSubject<Bool> = PublishSubject()
    private let loginSubject: PublishSubject<Void> = PublishSubject()
    
    init() {
        emailSubject = BehaviorSubject.init(value: nil)
        passwordSubject = BehaviorSubject.init(value: nil)
        mailChecking = mailCheckingSubject.asDriver(onErrorJustReturn: false)
        passwordChecking = passwordCheckingSubject.asDriver(onErrorJustReturn: false)
        login = loginSubject.asDriver(onErrorJustReturn: ())
                
    }
    
    func didTapLogin() {
        let emailResult = isValidEmail(getUserMail())
        let passwordResult = isValidPassword(getUserPassword())
        mailCheckingSubject.onNext(emailResult)
        passwordCheckingSubject.onNext(passwordResult)
        
        if emailResult && passwordResult {
            guard let mail = getUserMail() else {
                return
            }
            
            let user = UserModel(userName: "新使用者", emailAddress: mail, isVip: false, birthday: UserModel.getBirthday(), canEdit: true, canPost: true)
            
            userManager.didLoginSuccess(user: user)
            loginSubject.onNext(())
        }
    }
    
    func didTapGuest() {
        userManager.didGuestLoginSuccess()
        loginSubject.onNext(())
    }
}

private extension LoginWithRXViewModel {
    
    func getUserMail() -> String? {
        if let email = try? emailSubject.value() {
            return email
        }
        return nil
    }
    
    func getUserPassword() -> String? {
        if let password = try? passwordSubject.value() {
            return password
        }
        return nil
    }
}

//MARK: - Checkout Information
private extension LoginWithRXViewModel {
    
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
