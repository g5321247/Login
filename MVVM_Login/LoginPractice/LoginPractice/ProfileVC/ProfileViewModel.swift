//
//  ProfileViewModel.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/27.
//  Copyright © 2018 george.liu. All rights reserved.
//

import Foundation

protocol ProfileViewModelInputs {
    func didTapEditProfile()
    func didTapLogout()
    func updateInfo()
}

protocol ProfileViewModelOutputs {
    var isEditingProfile: ((Bool) -> Void)? { get set }
    var updateUserInfo: ((UserModel) -> Void)? { get set }
    var userNameCheckingCompletion: ((Bool) -> Void)? { get set }
    var logoutCompletion: (() -> Void)? { get set }
    func getUserInfo() -> UserModel?
}

class ProfileViewModel: ViewModelBinding, ViewModelDependency, ProfileViewModelInputs, ProfileViewModelOutputs {
  
    // MARK: Variable
    var inputs: ProfileViewModelInputs { return self }
    var outputs: ProfileViewModelOutputs { return self }
    let userManager = UserManager.shared    
    private var user: UserModel!
    
    // MARK: - ViewModelOutputParameter
    var isEditingProfile: ((Bool) -> Void)?
    var updateUserInfo: ((UserModel) -> Void)?
    var logoutCompletion: (() -> Void)?
    var userNameCheckingCompletion: ((Bool) -> Void)?
    
    // MARK: - Dependency Injection
    required init(withDependency user: UserModel) {
        self.user = user
    }
    
    // MARK: - ViewModelInputs
    func didTapEditProfile() {
        isEditingProfile?(userManager.userModel.canEdit)
    }
    
    func didTapLogout() {
        logoutCompletion?()
    }
        
    func getUserInfo() -> UserModel? {
        return user
    }
    
    func updateInfo() {
        guard let user = userManager.userModel else {
            return
        }
        updateUserInfo?(user)
    }
}
