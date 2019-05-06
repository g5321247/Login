//
//  ProfileWithRXViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/4.
//  Copyright © 2019 george.liu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileWithRxViewModelInputs {
    func didTapLogout()
    func didTapEdit()
}

protocol ProfileWithRXViewModelOutputs {
    var logout: Driver<Void> { get }
    var edit: Driver<Void> { get }
    var userModel: Driver<UserModel> { get }
}

class ProfileWithRXViewModel: ViewModelBinding, ProfileWithRxViewModelInputs, ProfileWithRXViewModelOutputs {
    
    var inputs: ProfileWithRxViewModelInputs { return self }
    
    var outputs: ProfileWithRXViewModelOutputs { return self }
    
    // MARK: - ViewModelOutputParameter
    var logout: Driver<Void>
    var edit: Driver<Void>
    var userModel: Driver<UserModel>
    
    // MARK: - Private Varible
    private let userManager = UserManager.shared
    private let logoutSubject: PublishSubject<Void> = PublishSubject()
    private let editSubject: PublishSubject<Void> = PublishSubject()
    private var userSubject: BehaviorSubject<UserModel>

    init() {
        logout = logoutSubject.asDriver(onErrorJustReturn: ())
        edit = editSubject.asDriver(onErrorJustReturn: ())
        userSubject = BehaviorSubject.init(value: userManager.userModel)
        userModel = userSubject.asDriver(onErrorJustReturn: UserModel())
    }
    
    // MARK: - ViewModelInputs
    func didTapEdit() {
        if userManager.userModel.canEdit {
            editSubject.onNext(())
        }
    }
    
    func didTapLogout() {
        logoutSubject.onNext(())
    }
    
    // MARK: - ViewModelOutputs

}
