//
//  ProfileWithRXViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/4.
//  Copyright © 2019 george.liu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileWithRXViewController: UIViewController {

    // MARK: - IB Variable
    @IBOutlet weak var igvProfilePic: UIImageView!
    @IBOutlet weak var llEmail: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var llUserName: UILabel!
    @IBOutlet weak var llBirthday: UILabel!
    @IBOutlet weak var llUserBirthday: UILabel!

    // MARK: - ViewModel
    private var viewModel: ProfileWithRXViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderView()
        bindViewModel()
    }
    
    // MARK: - IB Setup and Update
    private func renderView() {
        llUserName.isHidden = false
    }
    
    private func updateView(withUser user: UserModel) {
        llEmail.text = user.emailAddress
        llUserName.text = user.userName
        llUserBirthday.text = user.birthday
    
        // Check Vip Status
        llBirthday.isHidden = !user.isVip
        llUserBirthday.isHidden = !user.isVip
    }
    
    // MARK: - Inject ViewModel
    func inject() {
        viewModel = ProfileWithRXViewModel()
    }
    
    // MARK: - Bind ViewModel
    func bindViewModel() {
        //ViewModel Input binding
        btnEditProfile.rx.tap.bind(onNext: viewModel.inputs.didTapEdit).disposed(by: disposeBag)
        btnLogout.rx.tap.bind(onNext: viewModel.inputs.didTapLogout).disposed(by: disposeBag)
        
        //ViewModel Output binding
        viewModel.outputs.logout.drive(onNext: {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.userModel.drive(onNext: {[weak self] (user) in
            self?.updateView(withUser: user)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.edit.drive(onNext:
            {[weak self] in
                self?.performSegue(withIdentifier: "goToEditPage", sender: nil)
            
        }).disposed(by: disposeBag)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToEditPage" else {
            return
        }
        
        guard let editProfileVC = segue.destination as? EditProfileViewWithRXController else {
            return
        }
        
        editProfileVC.delegate = self
        editProfileVC.inject()
    }
}

extension ProfileWithRXViewController: EditProfileViewWithRXControllerDelegate {
    
    func updateUser(user: UserModel) {
        updateView(withUser: user)
    }
}
