//
//  LoginBaseView.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/25.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

class LoginBaseView: UIView {

    // MARK: UI Variable
    
    lazy var tfEmail: UITextField = {
       
        let textField = UITextField()
        let object = TextFieldObject(placeholder: "請輸入電子信箱")

        textField.set(with: object)
        
        return textField
        
    }()
    
    lazy var tfPassword: UITextField = {
        
        let textField = UITextField()
        let object = TextFieldObject(placeholder: "請輸入密碼")
        
        textField.set(with: object)
        
        return textField
        
    }()
    
    lazy var btnLogin: UIButton = {
       
        let button = UIButton(type: .system)
        
        let object = ButtonObject(title: "登入")
        
        button.set(with: object)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        
        let view = UIStackView()
        let object = StackViewObject(alignment: .leading, spacing: 15)
        
        view.set(
            with: object,
            views: [
                tfEmail,
                tfPassword,
                btnLogin
            ]
        )
        
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        // MARK: Add SubViews
        self.addSubviews(views: [stackView])
        
        //MARK: Views Constraints Setup
        tfEmailConstraints()
        stackViewConstraints()
    }
    
}

//MARK: Layout Constraint
extension LoginBaseView {
    
    private func stackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    private func tfEmailConstraints() {
        
        tfEmail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tfEmail.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
            ])
        
    }
    
}
