//
//  UserCell.swift
//  TwitterClone
//
//  Created by Per Kristensen on 11/06/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .purple
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .red
            return imageView
        }()
        
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
