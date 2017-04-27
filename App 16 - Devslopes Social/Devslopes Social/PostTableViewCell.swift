//
//  PostTableViewCell.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 26/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    func configureCell(post: Post) {
        captionTextView.text = post.caption
        likesLabel.text = "\(post.likes)"
    }

}
