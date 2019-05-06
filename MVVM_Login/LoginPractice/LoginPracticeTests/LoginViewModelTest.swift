//
//  LoginViewModelTest.swift
//  LoginPracticeTests
//
//  Created by george.liu on 2019/1/2.
//  Copyright © 2019 george.liu. All rights reserved.
//

import XCTest
@testable import LoginPractice

class LoginViewModelTest: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        loginViewModel = LoginViewModel()
    }

    override func tearDown() {
        loginViewModel = nil
    }
    
    //MARK: - Test Login
    func testLoginFailWithInvaildMailAddress() {
        var outputs = loginViewModel.outputs
        outputs.mailCheckingCompletion = { (isValid) in
            XCTAssert(isValid == false)
        }
        
        loginViewModel.inputs.setEmail("123")
        loginViewModel.inputs.didTapLogin()
    }
    
    func testLoginFailWithInvaildPassword() {
        var outputs = loginViewModel.outputs
        outputs.passwordCheckingCompletion = { (isValid) in
            XCTAssert(isValid == false)
        }
        
        loginViewModel.inputs.setPassword("123456")
        loginViewModel.inputs.didTapLogin()
    }
    
    func testLoginSuccessWithValidEmailAndPassword() {
        var outputs = loginViewModel.outputs
        outputs.mailCheckingCompletion = { (isValid) in
            XCTAssert(isValid == true)
        }
        
        outputs.passwordCheckingCompletion = { (isValid) in
            XCTAssert(isValid == true)
        }
        
        // Expectation Result
        outputs.loginCompletion = { (user) in
            XCTAssert(user == UserModel(userName: nil, emailAddress: "456@hello.com", canEdit: true, canPost: true))
        }
        
        loginViewModel.setEmail("456@hello.com")
        loginViewModel.setPassword("123456789")
        loginViewModel.inputs.didTapLogin()
    }
    
    func testLoginByGuest() {
        var outputs = loginViewModel.outputs
        outputs.loginCompletion = { (user) in
            XCTAssert(user == UserModel(userName: "Guest", emailAddress: "None", canEdit: false, canPost: false))
        }
        
        loginViewModel.inputs.didTapGuest()
    }
}
