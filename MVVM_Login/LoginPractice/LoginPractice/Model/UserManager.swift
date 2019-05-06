//
//  UserMode.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/27.
//  Copyright © 2018 george.liu. All rights reserved.
//

import Foundation

enum UserType {
    case signInUser
    case guest
}

struct UserModel: Equatable, Codable {
    var userName: String?
    var emailAddress: String
    var isVip: Bool
    var birthday: String?
    var canEdit: Bool
    var canPost: Bool
    
    init(
        userName: String? = "新使用者",
        emailAddress: String = "查不到使用者信箱",
        isVip: Bool = false,
        birthday: String? = nil,
        canEdit: Bool = false,
        canPost: Bool = false
        ) {
        
        self.userName = userName
        self.emailAddress = emailAddress
        self.isVip = isVip
        self.birthday = birthday
        self.canEdit = canEdit
        self.canPost = canPost
        
    }
    
    static func getBirthday() -> String {
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        let defaultBirthday = formatter.string(from: date)
        
        return defaultBirthday
    }
}

class UserManager {
    
    //MARK: - Varible
    static let shared = UserManager()
    private(set) var userType: UserType!
    private(set) var userModel: UserModel!
    
    private init() {}

    func didGuestLoginSuccess() {
        self.userType = .guest
        userModel = UserModel(userName: "Guest", emailAddress: "None", isVip: false, birthday: nil, canEdit: false, canPost: false)
    }

    func didLoginSuccess(user: UserModel) {
        self.userType = .signInUser

        userModel = user
        
        if user.emailAddress.contains("@tideiSun") {
            userModel.isVip = true
        }
    }
    
    func editProfile(name: String) {
        userModel.userName = name
    }
    
    func getMockUserModel() -> UserModel {
        
        let birthday = UserModel.getBirthday()
        
        return UserModel(userName: "Kevin", emailAddress: "456@hello.com", isVip: false, birthday: birthday, canEdit: true, canPost: true)
    }
}
