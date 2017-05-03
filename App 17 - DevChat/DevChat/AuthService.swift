//
//  AuthService.swift
//  DevChat
//
//  Created by Per Kristensen on 02/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Firebase

typealias Completion = (_ errorMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    
                    if errorCode == .errorCodeUserNotFound {
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            
                            if error != nil {
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                
                                if user?.uid != nil {
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        // TODO: Handle all other errors
                        self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                    }
                }
            } else {
                // Successfully logged in
                onComplete?(nil, user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid email address", nil)
            case .errorCodeWeakPassword:
                onComplete?("Password should be at least 6 characteres")
            case .errorCodeWrongPassword:
                onComplete?("Invalid password", nil)
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email already in use", nil)
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }
}
