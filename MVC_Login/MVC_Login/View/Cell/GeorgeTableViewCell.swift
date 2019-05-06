//
//  GeorgeTableViewCell.swift
//  MVC_Login
//
//  Created by George Liu on 2019/3/7.
//  Copyright © 2019 George Liu. All rights reserved.
//

import UIKit

class GeorgeTableViewCell: UITableViewCell {

    @IBOutlet weak var llTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(title: Int?) {
        guard let title = title else {
            return
        }
        
        llTitle.text = "\(title)"
    }
    
}
