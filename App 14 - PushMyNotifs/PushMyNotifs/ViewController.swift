//
//  ViewController.swift
//  PushMyNotifs
//
//  Created by Per Kristensen on 20/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
    }
}

