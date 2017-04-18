//
//  ReuseableView.swift
//  TacoPOP
//
//  Created by Per Kristensen on 18/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

protocol ReuseableView: class { }

extension ReuseableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
