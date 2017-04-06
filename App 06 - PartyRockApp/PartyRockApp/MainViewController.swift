//
//  ViewController.swift
//  PartyRockApp
//
//  Created by Per Kristensen on 05/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var partyRocks = [PartyRockModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let partyRock = PartyRockModel(imageUrl: "https://justonejess.com/wp-content/uploads/2016/05/devslopes-kickstarter-1.png", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/-VdQfX6q_a8\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Hello World!")
        
        partyRocks.append(partyRock)
        partyRocks.append(partyRock)
        partyRocks.append(partyRock)
        partyRocks.append(partyRock)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as? PartyTableViewCell {
            cell.updateUI(partyRock: partyRocks[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "VideoViewController", sender: partyRocks[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoViewController {
            if let partyRock = sender as? PartyRockModel {
                destination.partyRock = partyRock
            }
        }
    }
}

