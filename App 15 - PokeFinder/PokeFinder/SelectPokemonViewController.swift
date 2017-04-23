//
//  SelectPokemonViewController.swift
//  PokeFinder
//
//  Created by Per Kristensen on 22/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class SelectPokemonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemons: [Pokemon]!
    var completed: ((Int) -> ())!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemons = Pokemon.loadPokemons()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell{
            cell.configureCell(pokemon: pokemons[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - IBActions
    
    @IBAction func dismissViewPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completed(pokemons[indexPath.row].number)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}
