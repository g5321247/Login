//
//  UIView + .swift
//  Weather
//
//  Created by George Liu on 2018/12/17.
//  Copyright © 2018 George Liu. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: Change View Outline
    func borderSetup(
        borderWidth: CGFloat = 0,
        borderColor: CGColor? = nil
        ) {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        
    }
    
    func cornerSetup(
        cornerRadius: CGFloat = 0,
        maskToBounds: Bool = true
        ) {
        
        self.layer.masksToBounds = maskToBounds
        self.layer.cornerRadius = cornerRadius
        
    }
    
    //MARK: Add SubViews
    func addSubviews(views: [UIView]) {
        
        for view in views {
            self.addSubview(view)
        }
        
    }

}
