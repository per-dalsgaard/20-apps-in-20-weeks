//
//  LogInField.swift
//  CustomControls
//
//  Created by Per Kristensen on 28/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

enum FieldType {
    case Email
    case Password
}

@IBDesignable
class LogInField: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBInspectable var type = FieldType.Email
    @IBInspectable var useForMail = true.
    
    private let topLabel = UILabel()
    private let inputTextField = UITextField()
    private let bottomLineView = UIView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, type: FieldType) {
        self.type = type
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        type = useForMail ? .Email : .Password
        setupControls()
    }
    
    // MARK: UI Methods
    
    private func setupControls() {
        
    }

    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let t = textField.text?.characters
        
        if textField.text.characters.count > 0 {
            topLabel.textColor = UIColor.blue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.characters.count > 0 {
            topLabel.textColor = UIColor.lightGray
        } else {
            UIView.animate(withDuration: 0.25, animations: { 
                self.topLabel.alpha = 0
            }, completion: { done in
                self.topLabel.textColor = UIColor.blue
                
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topLabel.endEditing(true)
        return false
    }
}
