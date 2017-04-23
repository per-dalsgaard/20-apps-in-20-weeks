//
//  RoundedCornersImageView.swift
//  PokeFinder
//
//  Created by Per Kristensen on 23/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class RoundedCornersImageView: UIImageView {

    override func awakeFromNib() {
        layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
