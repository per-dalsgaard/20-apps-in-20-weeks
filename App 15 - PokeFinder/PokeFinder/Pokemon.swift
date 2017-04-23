//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Per Kristensen on 22/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

class Pokemon {
    
    var _number: Int!
    
    var name: String {
        get {
            return POKEMONS[_number - 1].capitalized
        }
        
    }
    
    var number: Int {
        get {
            if _number == nil {
                return 0
            }
            
            return _number
        }
        
        set {
            _number = newValue
        }
    }
    
    static func loadPokemons() -> [Pokemon] {
        var pokemons = [Pokemon]()
        for (index, _) in POKEMONS.enumerated() {
            let pokemon = Pokemon()
            pokemon.number = index + 1
            pokemons.append(pokemon)
        }
        return pokemons
    }
}
