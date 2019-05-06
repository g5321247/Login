//
//  ViewController.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/7.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myCustomView: LoginView = .fromNib()
//    let myCustomView: GeorgeTableView = .fromNib()
    
    let manager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCustomView.delegate = self
        
        view.addSubview(myCustomView)
    }
    
}

extension ViewController: LoginViewDelegate {
    
    func checkInfo(mail: String?, password: String?) {
        manager.checkInput(mail: mail, password: password, success: { [weak self] in
            let object = LoginViewObject(isValidMail: true, isValidPassword: true)
            self?.myCustomView.updateView(object: object)
            
            self?.performSegue(withIdentifier: "toNextVC", sender: nil)
            
        }) { [weak self] (isValidMail, isValidPassword) in
            let object = LoginViewObject(isValidMail: isValidMail, isValidPassword: isValidPassword)

//            self?.myCustomView.updateView(object: [1,2,3,4,5])
            self?.myCustomView.updateView(object: object)
        }
        
    }
}
