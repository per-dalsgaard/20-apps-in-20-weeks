//
//  SignInViewController.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 24/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInButtonPressed(_ sender: RoundCornersButton) {
        if let email = emailTextField.text , let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("PDK: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("PDK: Unable to authenticate with Firebase using email")
                        } else {
                            print("PDK: New email user created")
                        }
                    })
                }
            })
        }
    }
}
