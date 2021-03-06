//
//  SignInViewController.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 24/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Remove before production
        emailTextField.text = "per@codeph.dk"
        passwordTextField.text = "Hej12sa"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
//            performSegue(withIdentifier: FEED_SEGUE_IDENTIFIER, sender: nil)
//        }
    }
    
    // MARK: - IBActions
    
    @IBAction func signInButtonPressed(_ sender: RoundCornersButton) {
        if let email = emailTextField.text , let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("PDK: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(uid: user.uid, userData: ["provider":"Firebase"])
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("PDK: Unable to authenticate with Firebase using email")
                        } else {
                            print("PDK: New email user created")
                            if let user = user {
                                self.completeSignIn(uid: user.uid, userData: ["provider":"Firebase"])
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(uid: String, userData: Dictionary<String, String>) {
        DataSerice.ds.createFirebaseDbUser(uid: uid, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(uid, forKey: KEY_UID)
        print("PDK: Keychain result: \(keychainResult)")
        performSegue(withIdentifier: FEED_SEGUE_IDENTIFIER, sender: nil)
    }
}
