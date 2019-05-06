//
//  GeorgeViewController.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/8.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class GeorgeViewController: UIViewController {

    let myCustomView: NoDelegateView = .fromNib()
    let manager = LoginManager()
    
    var data: [Int] = [1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
    }
    
    private func renderUI() {
        
        myCustomView.delegate = self
        myCustomView.tableView.delegate = self
        myCustomView.tableView.dataSource = self
        let nib = UINib(nibName: String(describing: GeorgeTableViewCell.self), bundle: nil)
        
        myCustomView.tableView.register(nib, forCellReuseIdentifier: String(describing: GeorgeTableViewCell.self))

        view.addSubview(myCustomView)
    }
}

extension GeorgeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GeorgeTableViewCell.self), for: indexPath) as? GeorgeTableViewCell else { fatalError() }
        
        cell.updateCell(title: data[indexPath.row])
        return cell
    }
}

extension GeorgeViewController: LoginViewDelegate {
    
    func checkInfo(mail: String?, password: String?) {
        manager.checkInput(mail: mail, password: password, success: { [weak self] in
            let object = LoginViewObject(isValidMail: true, isValidPassword: true)
            
            self?.performSegue(withIdentifier: "toNextVC", sender: nil)
            
        }) { [weak self] (isValidMail, isValidPassword) in
            let object = LoginViewObject(isValidMail: isValidMail, isValidPassword: isValidPassword)
        }
        
    }
}
