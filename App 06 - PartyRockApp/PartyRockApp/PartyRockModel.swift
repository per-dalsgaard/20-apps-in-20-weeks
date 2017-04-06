//
//  PartyRockModel.swift
//  PartyRockApp
//
//  Created by Per Kristensen on 06/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

class PartyRockModel {
    
    private var _imageUrl: String!
    private var _videoUrl: String!
    private var _videoTitle: String!
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var videoUrl: String {
        return _videoUrl
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    init(imageUrl: String, videoUrl: String, videoTitle: String) {
        _imageUrl = imageUrl
        _videoUrl = videoUrl
        _videoTitle = videoTitle
    }
}
