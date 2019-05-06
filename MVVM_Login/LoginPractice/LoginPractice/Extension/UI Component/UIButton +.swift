//
//  UIButton +.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/25.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

//MARK: Button Setup Object
struct ButtonObject {
    
    var tinColor: UIColor
    var backgroundColor: UIColor
    var controlState: UIControl.State
    var title: String
    
    init(
        tinColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        backgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
        controlState: UIControl.State = .normal,
        title: String
        ) {
        
        self.tinColor = tinColor
        self.backgroundColor = backgroundColor
        self.controlState = controlState
        self.title = title
        
    }
    
}

extension UIButton {
    
    //MARK: Setup Button
    func set(with buttonObject: ButtonObject) {
        
        self.backgroundColor = buttonObject.backgroundColor
        self.tintColor = buttonObject.tinColor
        self.setTitle(buttonObject.title, for: buttonObject.controlState)
        
    }
    
}
