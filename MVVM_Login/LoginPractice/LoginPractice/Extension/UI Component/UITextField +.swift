//
//  UITextField.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/25.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

//MARK: TextField Setup Object
struct TextFieldObject {
    
    var placeholder: String
    var font: UIFont
    var borderStyle: UITextField.BorderStyle
    var autocorrectionType: UITextAutocorrectionType
    var keyboardType: UIKeyboardType
    var returnKeyType: UIReturnKeyType
    var clearButtonMode: UITextField.ViewMode
    
    init(
        placeholder: String,
        font: UIFont = UIFont.systemFont(ofSize: 15),
        borderStyle: UITextField.BorderStyle = UITextField.BorderStyle.roundedRect,
        autocorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.no,
        keyboardType: UIKeyboardType = UIKeyboardType.default,
        returnKeyType: UIReturnKeyType = UIReturnKeyType.done,
        clearButtonMode: UITextField.ViewMode = UITextField.ViewMode.whileEditing
        ) {
        
        self.placeholder = placeholder
        self.font = font
        self.borderStyle = borderStyle
        self.autocorrectionType = autocorrectionType
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.clearButtonMode = clearButtonMode
        
    }
    
}

extension UITextField {
    
    //MARK: Setup TextField
    func set(with textfieldObject: TextFieldObject) {
        
        self.placeholder = textfieldObject.placeholder
        self.font = textfieldObject.font
        self.borderStyle = textfieldObject.borderStyle
        self.autocorrectionType = textfieldObject.autocorrectionType
        self.keyboardType = textfieldObject.keyboardType
        self.returnKeyType = textfieldObject.returnKeyType
        self.clearButtonMode = textfieldObject.clearButtonMode
        
    }
    
}
