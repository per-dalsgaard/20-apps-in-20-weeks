//
//  DataService.swift
//  DevChat
//
//  Created by Per Kristensen on 03/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Firebase

let FIR_CHILD_USERS = "users"

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var mainStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    var imagesStorageRef: FIRStorageReference {
        return mainStorageRef.child("images")
    }

    var videosStorageRef: FIRStorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": "" as AnyObject, "lastName": "" as AnyObject]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
}
