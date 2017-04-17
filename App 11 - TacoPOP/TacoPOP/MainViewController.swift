//
//  MainViewController.swift
//  TacoPOP
//
//  Created by Per Kristensen on 17/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.addDropShadow()
    }
}
