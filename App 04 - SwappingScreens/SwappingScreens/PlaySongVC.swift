//
//  PlaySongVC.swift
//  SwappingScreens
//
//  Created by Per Kristensen on 02/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class PlaySongVC: UIViewController {

    @IBOutlet weak var songTitleLabel: UILabel!
    
    private var _selectedTitle: String!
    
    var selectedTitle: String {
        get {
            return _selectedTitle
        } set {
            _selectedTitle = newValue
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        songTitleLabel.text = _selectedTitle 
    }
}
