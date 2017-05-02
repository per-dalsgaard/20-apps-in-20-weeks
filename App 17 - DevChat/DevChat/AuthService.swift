//
//  AuthService.swift
//  DevChat
//
//  Created by Per Kristensen on 02/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                
                if let errorCode = FIRAuthErrorCode(rawValue: (error! as NSError).code) {
                    
                    if errorCode == .errorCodeUserNotFound {
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            
                            if error != nil {
                                // TODO: Show error to user
                            } else {
                                
                                if user?.uid != nil {
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            // TODO: Show error to user
                                        } else {
                                            // Successfully logged in
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        // TODO: Handle all other errors
                    }
                }
            } else {
                // Successfully logged in
            }
        })
    }
}
