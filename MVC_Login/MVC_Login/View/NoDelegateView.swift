//
//  NoDelegateView.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/8.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class NoDelegateView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refresh(_ sender: UIButton) {
        delegate?.checkInfo(mail: nil, password: nil)
    }
    
    weak var delegate: LoginViewDelegate?

}
