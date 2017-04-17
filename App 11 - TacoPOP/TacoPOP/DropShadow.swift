//
//  DropShadow.swift
//  TacoPOP
//
//  Created by Per Kristensen on 17/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

protocol DropShadow { }

extension DropShadow where Self: UIView {
    func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
