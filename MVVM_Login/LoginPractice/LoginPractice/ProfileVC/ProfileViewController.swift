//
//  ProfileViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/26.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - IB Variable
    @IBOutlet weak var igvProfilePic: UIImageView!
    @IBOutlet weak var llEmail: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var llUserName: UILabel!
    @IBOutlet weak var llBirthday: UILabel!
    @IBOutlet weak var llUserBirthday: UILabel!
    
    // MARK: - IB Action
    @IBAction func logout(_ sender: UIButton) {
        profileViewModel.inputs.didTapLogout()
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        profileViewModel.inputs.didTapEditProfile()
    }
    
    private func renderView() {
        llUserName.isHidden = false
    }
    
    // MARK: - Variable
    var profileViewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderView()
        bindViewModel()
        
        set(withUser: profileViewModel.outputs.getUserInfo())
    }
    
    // MARK: - ViewModel Injection
    func inject(withUser: UserModel) {
        profileViewModel = ProfileViewModel(withDependency: withUser)
    }
    
    //Update Views when model changed
    private func set(withUser user: UserModel?) {
        llEmail.text = user?.emailAddress
        llUserName.text = user?.userName
        llUserBirthday.text = user?.birthday
        
        guard let user = user else {
            return
        }
        
        llBirthday.isHidden = !user.isVip
        llUserBirthday.isHidden = !user.isVip
    }
    
    private func bindViewModel() {
        var outputs = profileViewModel.outputs
        
        outputs.updateUserInfo = { [weak self] (user) in
            
            self?.llBirthday.isHidden = !user.isVip
            self?.llUserBirthday.isHidden = !user.isVip
            
            self?.set(withUser: user)
        }
        
        outputs.isEditingProfile = { [weak self] (editing) in
            
            if editing {
                self?.performSegue(withIdentifier: "goToEditPage", sender: outputs.getUserInfo())
            }
        }
        
        outputs.logoutCompletion = { [weak self] () in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditPage" {
            
            guard let editProfileVC = segue.destination as? EditProfileViewController else {
                return
            }
            
            guard let user = sender as? UserModel else {
                return
            }
            
            editProfileVC.delegate = self
            editProfileVC.inject(withUser: user)
        }
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    
    func updateView() {
        profileViewModel.inputs.updateInfo()
    }
}
