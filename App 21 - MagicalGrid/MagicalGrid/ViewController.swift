//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Per Kristensen on 03/06/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numberOfViewPerRow = 15
    let numberOfColums = 30
    
    private var cells = [NSValue: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numberOfViewPerRow)
        
        for y in 0...numberOfColums {
            for x in 0...numberOfViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                cellView.frame = CGRect(x: CGFloat(x) * width, y: CGFloat(y) * width, width: width, height: width)
                view.addSubview(cellView)
                
                let point = getReferenceTypePoint(x, y)
                cells[point] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(numberOfViewPerRow)
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        
        let point = getReferenceTypePoint(x, y)
        guard let cellView = cells[point] else { return }
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)

        }, completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                cellView.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
    }
    
    private func getReferenceTypePoint(_ x: Int, _ y: Int) -> NSValue {
        return NSValue(cgPoint: CGPoint(x: x,y: y))
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

