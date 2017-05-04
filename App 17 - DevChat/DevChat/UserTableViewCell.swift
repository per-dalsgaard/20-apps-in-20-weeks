//
//  UserTableViewCell.swift
//  DevChat
//
//  Created by Per Kristensen on 04/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    
    func updateUi(user: User) {
        firstNameLabel.text = user.firstName
    }
    
    
    func setCheckmark(selected: Bool) {
        let imageName = selected ? "messageindicatorchecked1" : "messageindicator1"
        accessoryView = UIImageView(image: UIImage(named: imageName))
    }
    
    
}
