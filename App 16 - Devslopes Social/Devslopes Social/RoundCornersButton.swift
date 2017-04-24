//
//  RoundCornersButton.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 24/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class RoundCornersButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 1).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
        layer.cornerRadius = 2
    }

}
