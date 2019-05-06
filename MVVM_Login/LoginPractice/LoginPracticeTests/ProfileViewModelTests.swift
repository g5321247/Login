//
//  ProfileViewModelTests.swift
//  LoginPracticeTests
//
//  Created by george.liu on 2018/12/28.
//  Copyright © 2018 george.liu. All rights reserved.
//

import XCTest
@testable import LoginPractice

class ProfileViewModelTests: XCTestCase {
    
    var profileViewModel: ProfileViewModel!
    let userManager = UserManager.shared
    
    override func setUp() {
        
        // Mock user name is Kevin, emailAddress is "456@hello.com"
        let user = userManager.getMockUserModel()
        profileViewModel = ProfileViewModel(withDependency: user)
    }

    override func tearDown() {
        profileViewModel = nil
    }
    
    func testUserModelWithMock() {
        let user = profileViewModel.outputs.getUserInfo()
        let user2 = UserModel(userName: "Kevin", emailAddress: "456@hello.com", canEdit: true, canPost: true)
        
        XCTAssert(user! == user2)
    }
    
    //MARK: - Test Edit Profile
    func testCanEditProfileIfUserIsLoginUser() {
        
        let user = userManager.getMockUserModel()
        userManager.didLoginSuccess(user: user)
        
        var output = profileViewModel.outputs
        output.isEditingProfile = { editing in
            XCTAssert(editing == true)
        }
        
        profileViewModel.inputs.didTapEditProfile()
    }
    
    func testCanNotEditProfileIfUserIsGuset() {
        
        userManager.didGuestLoginSuccess()
        
        var output = profileViewModel.outputs
        output.isEditingProfile = { editing in
            XCTAssert(editing == false)
        }
        
        profileViewModel.inputs.didTapEditProfile()
    }
    
    //MARK: - Test Confirm Editing User Name
    func testCanNotConfirmEditingIfNewNameIsEmpty() {
        
        var output = profileViewModel.outputs
        output.userNameCheckingCompletion = { isValid in
            XCTAssert(isValid == false)
        }
        
        profileViewModel.inputs.editUserName("")
        profileViewModel.inputs.didTapConfirmEditing()
    }
    
    func testCanNotConfirmEditingIfNewNameIsOver10Charaters() {
        
        var output = profileViewModel.outputs
        output.userNameCheckingCompletion = { isValid in
            XCTAssert(isValid == false)
        }
        
        profileViewModel.inputs.editUserName("12345678901")
        profileViewModel.inputs.didTapConfirmEditing()
    }

    func testCanConfirmEditingIfNewNameIsGeorge() {
        
        var output = profileViewModel.outputs
        output.updateUserInfo = { user in
            XCTAssert(user.userName == "George")
        }
        
        profileViewModel.inputs.editUserName("George")
        profileViewModel.inputs.didTapConfirmEditing()
    }

    //MARK: - Test Cancel Editing User Name

    func testCancelEditingIfNewNameIsGeorge() {
        
        // Mock user name is Kevin
        var output = profileViewModel.outputs
        output.updateUserInfo = { user in
            XCTAssert(user.userName == "Kevin")
        }

        profileViewModel.inputs.editUserName("George")
        profileViewModel.inputs.didTapCancleEditing()
    }
    
    //MARK: - Test Logout
    func testLogout() {
        var output = profileViewModel.outputs
        output.logoutCompletion = {
            XCTAssert(true)
        }
        
        profileViewModel.inputs.didTapLogout()
    }
}
