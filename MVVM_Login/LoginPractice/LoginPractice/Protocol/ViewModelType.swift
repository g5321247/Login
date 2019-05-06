//
//  ViewModelType.swift
//  LoginPractice
//
//  Created by george.liu on 2018/12/26.
//  Copyright © 2018 george.liu. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    
    associatedtype Inputs
    associatedtype Outputs
    
    var inputs: Inputs { get }
    var outputs: Outputs { get }
}

protocol ViewModelDependency {
    
    associatedtype Dependency
    init (withDependency dependency: Dependency)
}
