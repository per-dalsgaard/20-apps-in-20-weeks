//
//  Pokemon.swift
//  PokeDex
//
//  Created by Per Kristensen on 15/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
    }
    
}
