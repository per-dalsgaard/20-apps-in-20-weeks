//
//  VideoViewController.swift
//  PartyRockApp
//
//  Created by Per Kristensen on 05/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var _partyRock: PartyRockModel!
    var partyRock: PartyRockModel {
        get {
            return _partyRock
        } set {
            _partyRock = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        videoTitleLabel.text = _partyRock.videoTitle
        webView.loadHTMLString(_partyRock.videoUrl, baseURL: nil)
    }
}
