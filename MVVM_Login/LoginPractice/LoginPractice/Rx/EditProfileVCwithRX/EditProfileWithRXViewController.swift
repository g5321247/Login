//
//  EditProfileViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/8.
//  Copyright © 2019 george.liu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EditProfileViewWithRXControllerDelegate: AnyObject {
    func updateUser(user: UserModel)
}

class EditProfileViewWithRXController: UIViewController {
    
    weak var delegate: EditProfileViewWithRXControllerDelegate?
    
    // MARK: - IB Variable
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var btnConfirmEditing: UIButton!
    @IBOutlet weak var btnCancelEditing: UIButton!
    @IBOutlet weak var llErrorName: UILabel!
    
    let disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    var viewModel: EditProfileWithRXViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderUI()
        bind()
    }
    
    // MARK: - Inject ViewModel
    func inject() {
        viewModel = EditProfileWithRXViewModel()
    }
    
    // MARK: - IB Setup and Update
    private func renderUI() {
        llErrorName.isHidden = true
    }
    
    // MARK: - Bind ViewModel
    private func bind() {
        //ViewModel Input binding
        tfUserName.rx.text.bind(to: viewModel.inputs.newNameSubject).disposed(by: disposeBag)
        btnConfirmEditing.rx.tap.bind(onNext: viewModel.inputs.didTapConfirm).disposed(by: disposeBag)
        btnCancelEditing.rx.tap.bind(onNext: viewModel.inputs.didTapCancel).disposed(by: disposeBag)
        
        //ViewModel Output binding
        
        viewModel.outputs.userNameChecking.drive(onNext: { [weak self] (isValid) in
            self?.llErrorName.isHidden = isValid
        }).disposed(by: disposeBag)
        
        viewModel.outputs.confirmEditing.drive(onNext: { [weak self] (user) in
            self?.delegate?.updateUser(user: user)
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.cancelEditing.drive(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
