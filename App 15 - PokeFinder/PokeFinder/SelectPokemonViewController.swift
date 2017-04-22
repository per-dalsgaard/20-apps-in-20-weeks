//
//  SelectPokemonViewController.swift
//  PokeFinder
//
//  Created by Per Kristensen on 22/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class SelectPokemonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var pokemons: [Pokemon]!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemons = Pokemon.loadPokemons()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}
