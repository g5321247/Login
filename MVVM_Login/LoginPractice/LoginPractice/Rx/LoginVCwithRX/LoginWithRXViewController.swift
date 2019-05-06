//
//  LoginWithRXViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2019/1/3.
//  Copyright © 2019 george.liu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginWithRXViewController: UIViewController {

    // MARK: - IB Variable
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var llEmailError: UILabel!
    @IBOutlet weak var llPasswordError: UILabel!
    
    // MARK: - Variable
    let viewModel = LoginWithRXViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderUI()
        bindViewModel()
    }
    
    private func renderUI() {
        llEmailError.isHidden = true
        llPasswordError.isHidden = true
    }

    //MARK: - Bind ViewModel
    private func bindViewModel() {
        //ViewModel Input binding
        tfEmail.rx.text.bind(to: viewModel.inputs.emailSubject).disposed(by: disposeBag)
        tfPassword.rx.text.bind(to: viewModel.inputs.passwordSubject).disposed(by: disposeBag)
        btnLogin.rx.tap.bind(onNext: viewModel.inputs.didTapLogin).disposed(by: disposeBag)
        btnGuest.rx.tap.bind(onNext: viewModel.inputs.didTapGuest).disposed(by: disposeBag)
        
        //ViewModel Output binding
        viewModel.outputs.mailChecking.drive(onNext: { [weak self] (isValid) in
            self?.llEmailError.isHidden = isValid
        }).disposed(by: disposeBag)
        
        viewModel.outputs.passwordChecking.drive(onNext: { [weak self] (isValid) in
            self?.llPasswordError.isHidden = isValid
        }).disposed(by: disposeBag)
        
        viewModel.outputs.login.drive(onNext: { [weak self] () in
            self?.performSegue(withIdentifier: "toProfilePage", sender: nil)
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfilePage" {
            guard let profileVC = segue.destination as? ProfileWithRXViewController else {
                return
            }
            
            profileVC.inject()
        }
    }
}
