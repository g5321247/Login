//
//  EditProfileViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/3.
//  Copyright © 2019 george.liu. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func updateView()
}

class EditProfileViewController: UIViewController {
    
    weak var delegate: EditProfileViewControllerDelegate?
    
    // MARK: - IB Variable
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var btnConfirmEditing: UIButton!
    @IBOutlet weak var btnCancelEditing: UIButton!
    @IBOutlet weak var llErrorName: UILabel!

    // MARK: - IB Action
    @IBAction func inputUserName(_ sender: UITextField) {
        editProfileViewModel.inputs.editUserName(sender.text)
    }
    
    @IBAction func confirmEditing(_ sender: UIButton) {
        editProfileViewModel.inputs.didTapConfirmEditing()
    }
    
    @IBAction func cancelEditing(_ sender: UIButton) {
        editProfileViewModel.inputs.didTapCancleEditing()
    }

    // MARK: - ViewModel
    var editProfileViewModel: EditProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderView()
        bindViewModel()
    }
    
    private func renderView() {
        llErrorName.isHidden = true
    }
    
    // MARK: - Inject ViewModel
    func inject(withUser user: UserModel) {
        editProfileViewModel = EditProfileViewModel(withDependency: user)
    }
    
    // MARK: - Binding
    func bindViewModel() {
        var outputs = editProfileViewModel.outputs
        
        outputs.userNameCheckingCompletion = { [weak self] (isValid) in
            self?.llErrorName.isHidden = isValid
        }
        
        outputs.updateUserInfo = { [weak self] (user) in
            self?.delegate?.updateView()
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
