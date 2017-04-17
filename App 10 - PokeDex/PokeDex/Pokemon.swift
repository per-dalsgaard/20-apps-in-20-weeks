//
//  Pokemon.swift
//  PokeDex
//
//  Created by Per Kristensen on 15/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionName: String!
    fileprivate var _nextEvolutionText: String!
    fileprivate var _nextEvolutionLevel: String!
    fileprivate var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            return ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            return ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            return ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            return ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            return ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            return ""
        }
        return _nextEvolutionId
    }
    
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            return ""
        }
        return _nextEvolutionName
    }
    
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            return ""
        }
        return _nextEvolutionLevel
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonUrl).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                            
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    if let uri = descArr[0]["resource_uri"] {
                        let descriptionUrl = "\(URL_BASE)\(uri)"
                        Alamofire.request(descriptionUrl).responseJSON(completionHandler: { response in
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvolution
                    
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvolutionId
                            }
                            
                            if let levelExists = evolutions[0]["level"] as? Int {
                                self._nextEvolutionLevel = "\(levelExists)"
                            } else {
                                self._nextEvolutionLevel = ""
                            }
                        }
                        
                    }
                }
            }
            completed()
        }
    }
    
}
