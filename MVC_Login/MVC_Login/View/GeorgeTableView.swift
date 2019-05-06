//
//  GeorgeTableView.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/7.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class GeorgeTableView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refresh(_ sender: UIButton) {
        delegate?.checkInfo(mail: nil, password: nil)
    }
        
    weak var delegate: LoginViewDelegate?

    private var data: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: String(describing: GeorgeTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: GeorgeTableViewCell.self))
    }
    
    func updateView(object: [Int]) {
        data = object
        tableView.reloadData()
    }

}

extension GeorgeTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GeorgeTableViewCell.self), for: indexPath) as? GeorgeTableViewCell else { fatalError() }
        
        cell.updateCell(title: data[indexPath.row])
        return cell
    }
    
}


