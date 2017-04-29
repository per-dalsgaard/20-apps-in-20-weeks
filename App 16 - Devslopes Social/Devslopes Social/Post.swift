//
//  Post.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 27/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _postId: String!
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postRef: FIRDatabaseReference!
    
    var postId: String {
        return _postId
    }
    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    init(postId: String, caption: String, imageUrl: String, likes: Int) {
        self._postId = postId
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postId: String, postData: Dictionary<String, AnyObject>) {
        self._postId = postId
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataSerice.ds.REF_POSTS.child(postId)
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
           _likes = _likes - 1
        }
        _postRef.child("likes").setValue(_likes)
    }
}
