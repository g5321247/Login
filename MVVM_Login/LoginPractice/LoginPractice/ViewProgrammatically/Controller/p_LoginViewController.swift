//
//  ViewController.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/25.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit


// MARK: ViewModel

// MARK: Add SubViews

// MARK: Binding



class p_LoginViewController: UIViewController {
    
    // MARK: UI Variable
    lazy var baseView: LoginBaseView = {
        
        let view = LoginBaseView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.frame.height
            )
        )
        
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(views: [baseView])
        
    }


}


