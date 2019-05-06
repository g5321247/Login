//
//  EditProfileViewModel.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/3.
//  Copyright © 2019 george.liu. All rights reserved.
//

import Foundation


// MARK: - ViewModelInputParameter

// MARK: - ViewModelOutputParameter

// MARK: - ViewModelInputs


protocol EditProfileViewModelInputs {
    func editUserName(_ name: String?)
    func didTapConfirmEditing()
    func didTapCancleEditing()
}

protocol EditProfileViewModelOutputs {
    var userNameCheckingCompletion: ((Bool) -> Void)? { get set }
    var updateUserInfo: ((UserModel) -> Void)? { get set }
}


class EditProfileViewModel: ViewModelBinding, EditProfileViewModelInputs, EditProfileViewModelOutputs,ViewModelDependency {

    var inputs: EditProfileViewModelInputs { return self }
    var outputs: EditProfileViewModelOutputs { return self }
    let userManager = UserManager.shared
    private var user: UserModel!
    private var newNameString: String?
    
    // MARK: - ViewModelOutputs
    var userNameCheckingCompletion: ((Bool) -> Void)?
    var updateUserInfo: ((UserModel) -> Void)?
    
    func didTapConfirmEditing() {
        let nameIsValid = isValidName(name: newNameString)
        userNameCheckingCompletion?(nameIsValid)
        
        if nameIsValid {
            userManager.editProfile(name: newNameString!)
            updateUserInfo?(user)
        }
    }
    
    func didTapCancleEditing() {
        guard let user = userManager.userModel else {
            return
        }
        updateUserInfo?(user)
    }

    func editUserName(_ name: String?) {
        newNameString = name
    }
    
    // MARK: - Dependency Injection
    required init(withDependency dependency: UserModel) {
        user = dependency
    }
}

//MARK: - Check Name is Valid
extension EditProfileViewModel {
    
    private func isValidName(name: String?) -> Bool {
        guard let name = name else {
            return false
        }
        return name.count < 10 && name.count > 0
    }
}
