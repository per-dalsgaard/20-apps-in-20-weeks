//
//  NibLoadableView.swift
//  TacoPOP
//
//  Created by Per Kristensen on 18/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
