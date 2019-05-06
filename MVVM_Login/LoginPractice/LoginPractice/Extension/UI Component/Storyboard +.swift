//
//  Storyboard +.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/26.
//  Copyright © 2018 george.liu. All rights reserved.
//

import UIKit

enum StoryboardCase: String {
    
    case main = "Main"
    case profile = "Profile"
    
}


extension UIStoryboard {
    
    static func storyboardFile(name: StoryboardCase) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: nil)
    }
    
}
