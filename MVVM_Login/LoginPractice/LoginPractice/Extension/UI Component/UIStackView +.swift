//
//  UIStackView +.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/25.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

//MARK: StackView Setup Object
struct StackViewObject {
    
    var axis: NSLayoutConstraint.Axis
    var distribution: UIStackView.Distribution
    var alignment: UIStackView.Alignment
    var spacing: CGFloat
    
    init(
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .equalSpacing,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat
        ) {
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
    }
    
}

extension UIStackView {
    
    //MARK: Setup StackView
    func set(with stackViewObject: StackViewObject, views: [UIView]) {
        
        self.axis = stackViewObject.axis
        self.distribution = stackViewObject.distribution
        self.alignment = stackViewObject.alignment
        self.spacing = stackViewObject.spacing
        
        self.addSubviews(views: views)
        
    }
    
}

