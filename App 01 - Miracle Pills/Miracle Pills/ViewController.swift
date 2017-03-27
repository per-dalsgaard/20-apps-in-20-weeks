//
//  ViewController.swift
//  Miracle Pills
//
//  Created by Per Kristensen on 14/03/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var successImageView: UIImageView!
    
    @IBAction func buyNowButtonPressed() {
        for view in view.subviews {
            view.isHidden = true
        }
        
        successImageView.isHidden = false
    }
}

