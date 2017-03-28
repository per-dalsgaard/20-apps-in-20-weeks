//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Per Kristensen on 27/03/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var images = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var contentWidth: CGFloat = 0.0
        
        let scrollViewWidth = scrollView.frame.size.width
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            newX = scrollViewWidth / 2 + scrollViewWidth * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
        }
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }
    
   
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        // TODO
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        // TODO
        scrollView.setContentOffset(CGPoint(x: 10, y: 0), animated: true)
    }
}

