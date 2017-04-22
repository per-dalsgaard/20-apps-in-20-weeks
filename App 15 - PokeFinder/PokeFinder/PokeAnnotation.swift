//
//  PokeAnnotation.swift
//  PokeFinder
//
//  Created by Per Kristensen on 22/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation



class PokeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemonNumber: Int
    var pokemonName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, pokemonNumber: Int) {
        self.coordinate = coordinate
        self.pokemonNumber = pokemonNumber
        self.pokemonName = POKEMONS[pokemonNumber - 1].capitalized
        self.title = self.pokemonName
    }
}
