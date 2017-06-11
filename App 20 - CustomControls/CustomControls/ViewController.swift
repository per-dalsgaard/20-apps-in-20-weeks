//
//  ViewController.swift
//  CustomControls
//
//  Created by Per Kristensen on 28/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inputEmail: LogInField!
    var inputPassword: LogInField!

    override func viewDidLoad() {
        super.viewDidLoad()

        inputEmail = LogInField(frame: CGRect(x: view.width / 2 - 100, y: view.centerY - 20, width: 200, height: 400), type: .Email)
        inputPassword = LogInField(frame: CGRect(x: view.width / 2 - 100, y: view.centerY + 20, width: 200, height: 400), type: .Password)
        
        view.addSubview(inputEmail)
        view.addSubview(inputPassword)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

