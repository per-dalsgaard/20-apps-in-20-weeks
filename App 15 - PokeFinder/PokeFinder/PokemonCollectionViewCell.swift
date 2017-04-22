//
//  PokemonCollectionViewCell.swift
//  PokeFinder
//
//  Created by Per Kristensen on 22/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        thumbImageView.image = UIImage(named: pokemon.name)
    }
}
