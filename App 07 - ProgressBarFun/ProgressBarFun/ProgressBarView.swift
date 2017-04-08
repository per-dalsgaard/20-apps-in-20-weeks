//
//  ProgressBarView.swift
//  ProgressBarFun
//
//  Created by Per Kristensen on 08/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    private var _innerProgress: CGFloat = 0.0
    
    var progress: CGFloat {
        set(newProgress) {
            if newProgress < 0.0 {
                _innerProgress = 0.0
            } else if newProgress > 1.0 {
                _innerProgress = 1.0
            } else {
                _innerProgress = newProgress
            }
            setNeedsDisplay()
        } get {
            return _innerProgress * bounds.width
        }
    }

    override func draw(_ rect: CGRect) {
        ProgressBarDraw.drawProgresBar(frame: bounds, progress: progress)
    }
}
