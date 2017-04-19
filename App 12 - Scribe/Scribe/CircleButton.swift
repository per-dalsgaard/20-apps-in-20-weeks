//
//  CircleButton.swift
//  Scribe
//
//  Created by Per Kristensen on 19/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
