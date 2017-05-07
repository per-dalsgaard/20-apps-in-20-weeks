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
    
    var pullRequestsRef: FIRDatabaseReference {
        return mainRef.child("pullRequests")
    }
    
    var imagesStorageRef: FIRStorageReference {
        return mainStorageRef.child("images")
    }

    var videosStorageRef: FIRStorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String, firstName: String, lastName: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName": firstName as AnyObject, "lastName": lastName as AnyObject]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullRequest(senderUid: String, recipients: [User], mediaUrl: URL, textSnippet: String? = nil) {
        var pr: Dictionary<String, AnyObject> = ["mediaUrl": mediaUrl.absoluteString as AnyObject,
                  "openCount": 0 as AnyObject,
                  "timeStamp": NSDate().timeIntervalSince1970 as AnyObject,
                  "userId": senderUid as AnyObject]
        if let textSnippet = textSnippet {
            pr["textSnippet"] = textSnippet as AnyObject
        }
        
        var watchersDict = Dictionary<String, Bool>()
        for user in recipients {
            watchersDict[user.uid] = true
        }
        
        pr["watchers"] = watchersDict as AnyObject
        pullRequestsRef.childByAutoId().setValue(pr)
    }
}
