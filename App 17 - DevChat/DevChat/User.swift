//
//  User.swift
//  DevChat
//
//  Created by Per Kristensen on 04/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

struct User {
    
    private var _uid: String
    private var _firstName: String
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
}
