//
//  PostTableViewCell.swift
//  Devslopes Social
//
//  Created by Per Kristensen on 26/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    
    var post: Post!
    var likesRef: FIRDatabaseReference!

    
    func configureCell(post: Post, postImage: UIImage?) {
        likesRef = DataSerice.ds.REF_CURRENT_USER.child("likes").child(post.postId)

        self.post = post
        captionTextView.text = post.caption
        likesLabel.text = "\(post.likes)"
        
        if let postImage = postImage {
            postImageView.image = postImage
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 1024 * 1024 * 2, completion: { (data, error) in
                if error != nil {
                    print("Error!")
                } else {
                    print("Image downloaded from Firebase storage")
                    if let imageData = data {
                        if let image = UIImage(data: imageData) {
                            self.postImageView.image = image
                            FeedViewController.imageCache.setObject(image, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesButton.setImage(UIImage(named: "empty-heart")!, for: .normal)
            } else {
                self.likesButton.setImage (UIImage(named: "filled-heart")!, for: .normal)
            }
        })
    }
    
    @IBAction func likeButtonPressed(sender: UIButton) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesButton.setImage(UIImage(named: "filled-heart"), for: .normal)
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likesButton.setImage (UIImage(named: "empty-heart"), for: .normal)
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()

            }
        })
    }
}
