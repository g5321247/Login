//
//  LoginViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/26.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IB Variable
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    
    // MARK: - IB Action
    @IBAction func inputEmail(_ sender: UITextField) {
        viewModel.inputs.setEmail(sender.text)
    }
    
    @IBAction func inputPassword(_ sender: UITextField) {
        viewModel.inputs.setPassword(sender.text)
    }
    
    @IBAction func login(_ sender: UIButton) {
        viewModel.inputs.didTapLogin()
    }
    
    @IBAction func guestLogin(_ sender: UIButton) {
        viewModel.inputs.didTapGuest()
    }
    
    // MARK: - Variable
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderUI()
        bindViewModel()
    }
    
    private func renderUI() {
        llEmailError.isHidden = true
        llPasswordError.isHidden = true
    }
    
    private func bindViewModel() {
        var outputs = viewModel.outputs
        
        outputs.mailCheckingCompletion = { [weak self] (isValid) in
            self?.llEmailError.isHidden = isValid
        }
        
        outputs.passwordCheckingCompletion = { [weak self] (isValid) in
            self?.llPasswordError.isHidden = isValid
        }
        
        outputs.loginCompletion = { [weak self] (user) in
            self?.performSegue(withIdentifier: "toProfilePage", sender: user)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfilePage" {
            guard let profileVC = segue.destination as? ProfileViewController else {
                return
            }
            
            guard let user = sender as? UserModel else {
                return
            }

            profileVC.inject(withUser: user)
        }
    }
}
