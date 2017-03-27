//
//  ViewController.swift
//  Miracle Pills
//
//  Created by Per Kristensen on 14/03/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {

    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var chooseStateButton: UIButton!
    
    let states = ["Alaska", "Arkansas", "Alabama", "California", "Maine", "New York",]
    
    @IBAction func buyNowButtonPressed() {
        for view in view.subviews {
            view.isHidden = true
        }
        
        successImageView.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    @IBAction func chooseStateButtonPressed() {
        let selectStateMode = !statePicker.isHidden
        if selectStateMode {
            let selectedState = states[statePicker.selectedRow(inComponent: 0)]
            chooseStateButton.setTitle(selectedState, for: .normal)
        }
        
        countryLabel.isHidden = !selectStateMode
        countryTextField.isHidden = !selectStateMode
        zipCodeLabel.isHidden = !selectStateMode
        zipCodeTextField.isHidden = !selectStateMode
        
        statePicker.isHidden = selectStateMode
    }
}

