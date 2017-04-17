//
//  Taco.swift
//  TacoPOP
//
//  Created by Per Kristensen on 17/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

enum TacoShell: Int {
    case Flour = 1
    case Corn = 2
}

enum TacoProtein: String {
    case Beef = "Beef"
    case Chicken = "Chicken"
    case Brisket = "Brisket"
    case Fish = "Fish"
}

enum TacoCondiment: Int {
    case Loaded = 1
    case Plain = 2
}

struct Taco {
    private var _id: Int!
    private var _productName: String!
    private var _shellId: TacoShell!
    private var _proteinId: TacoProtein!
    private var _condimentId: TacoCondiment!

    var id: Int {
        return _id
    }
    
    var productName: String {
        return _productName
    }
    
    var shellId: TacoShell {
        return _shellId
    }
    
    var proteinId: TacoProtein {
        return _proteinId
    }
    
    var condimentId: TacoCondiment {
        return _condimentId
    }
    
    init(id: Int, productName: String, shellId: Int, proteinId: Int, condimentId: Int) {
        _id = id
        _productName = productName
        
        switch shellId {
        case 2:
            _shellId = .Corn
        default:
            _shellId = .Flour
        }
        
        switch proteinId {
        case 2:
            _proteinId = .Chicken
        case 3:
            _proteinId = .Brisket
        case 4:
            _proteinId = .Fish
        default:
            _proteinId = .Beef
        }
        
        switch condimentId {
        case 2:
            _condimentId = .Plain
        default:
            _condimentId = .Loaded
        }
    }
}
