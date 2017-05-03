//
//  DataService.swift
//  DevChat
//
//  Created by Per Kristensen on 03/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
