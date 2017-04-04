//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Per Kristensen on 02/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != .Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                switch operation {
                case .Divide:
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                case .Multiply:
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                case .Subtract:
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                case .Add:
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                default:
                    print("Should not be possible")
                }
                
                leftValString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

