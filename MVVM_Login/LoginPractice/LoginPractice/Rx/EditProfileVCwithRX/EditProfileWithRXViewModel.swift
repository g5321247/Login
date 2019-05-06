//
//  EditProfileWithRXViewModel.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/8.
//  Copyright © 2019 george.liu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EditProfileWithRXViewModelInputs {
    var newNameSubject: BehaviorSubject<String?> { get }
    func didTapConfirm()
    func didTapCancel()
}

protocol EditProfileWithRXViewModelOutputs {
    var userNameChecking: Driver<Bool> { get }
    var confirmEditing: Driver<UserModel> { get }
    var cancelEditing: Driver<Void> { get }
}

class EditProfileWithRXViewModel: EditProfileWithRXViewModelInputs, EditProfileWithRXViewModelOutputs, ViewModelBinding {
    
    var inputs: EditProfileWithRXViewModelInputs { return self }
    var outputs: EditProfileWithRXViewModelOutputs { return self }
    
    // MARK: - ViewModelInputParameter
    var newNameSubject: BehaviorSubject<String?>
    
    // MARK: - ViewModelOutputParameter
    var userNameChecking: Driver<Bool>
    var confirmEditing: Driver<UserModel>
    var cancelEditing: Driver<Void>
    
    // MARK: - Private Varible
    private let userManager = UserManager.shared
    private let userNameCheckingSubject: PublishSubject<Bool> = PublishSubject()
    private let confirmEditingSubject: PublishSubject<UserModel> = PublishSubject()
    private let cancelEditingSubject: PublishSubject<Void> = PublishSubject()
    
    init() {
        newNameSubject = BehaviorSubject.init(value: nil)
        userNameChecking = userNameCheckingSubject.asDriver(onErrorJustReturn: false)
        confirmEditing = confirmEditingSubject.asDriver(onErrorJustReturn: UserModel())
        cancelEditing = cancelEditingSubject.asDriver(onErrorJustReturn: ())
    }
    
    func didTapConfirm() {
        let nameResult = isValidName(name: getNewName())
        
        if nameResult {
            guard let name = getNewName() else {
                return
            }
            
            userManager.editProfile(name: name)
            confirmEditingSubject.onNext(userManager.userModel)
        }
    }
    
    func didTapCancel() {
        cancelEditingSubject.onNext(())
    }
}

private extension EditProfileWithRXViewModel {
    
    func getNewName() -> String? {
        guard let name = try? newNameSubject.value() else {
            return nil
        }
        
        return name
    }
}

//Checkout Information
private extension EditProfileWithRXViewModel {
    
    func isValidName(name: String?) -> Bool {
        guard let name = name else {
            return false
        }
        
        return name.count > 0 && name.count < 10
    }
}
