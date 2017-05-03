//
//  LogInViewController.swift
//  DevChat
//
//  Created by Per Kristensen on 02/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: RoundTextField!
    @IBOutlet weak var passwordTextField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text , let password = passwordTextField.text , (email.characters.count > 0 && password.characters.count > 0) {
                AuthService.instance.login(email: email, password: password, onComplete: { (errorMsg, data) in
                    if let errorMsg = errorMsg {
                        let alert = UIAlertController(title: "Error Authentication", message: errorMsg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
            let alert = UIAlertController(title: "Username and Password required", message: "You must enter both an email and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
