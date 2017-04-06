//
//  PartyTableViewCell.swift
//  PartyRockApp
//
//  Created by Per Kristensen on 06/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {

    @IBOutlet weak var videoPreviewImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(partyRock: PartyRockModel) {
        videoTitleLabel.text = partyRock.videoTitle
        let videoUrl = URL(string: partyRock.imageUrl)!
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: videoUrl)
                DispatchQueue.global().sync {
                    self.videoPreviewImageView.image = UIImage(data: data)
                }
            } catch {
                print("Ooooops!")
            }
        }
    }
}
