//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Per Kristensen on 15/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvolutionImageView: UIImageView!
    @IBOutlet weak var nextEvolutionImageView: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImageView.image = image
        currentEvolutionImageView.image = image
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }

    }
    
    func updateUI() {
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImageView.isHidden = true
        } else {
            nextEvolutionImageView.isHidden = false
            nextEvolutionImageView.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            let nextEvolutionDescription = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evolutionLabel.text = nextEvolutionDescription
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
