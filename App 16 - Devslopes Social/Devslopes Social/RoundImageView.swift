//
//  RoundImageView.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 26/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
}
