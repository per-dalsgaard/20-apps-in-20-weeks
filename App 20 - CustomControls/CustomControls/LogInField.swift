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
    @IBInspectable var useForMail = true
    
    private let topLabel = UILabel()
    private let inputTextField = UITextField()
    private let bottomLineView = UIView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControls()
    }
    
    init(frame: CGRect, type: FieldType) {
        self.type = type
        super.init(frame: frame)
        setupControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControls()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        type = useForMail ? .Email : .Password
        setupControls()
    }
    
    // MARK: UI Methods
    
    private func setupControls() {
        addSubview(topLabel)
        topLabel.frame = CGRect(x: 0, y: boundsHeight / 2, width: boundsWidth, height: 20)
        topLabel.alpha = 0
        topLabel.text = type == .Email ? "Email" : "Password"
        topLabel.textAlignment = .left
        topLabel.textColor = .blue
        topLabel.font = UIFont.systemFont(ofSize: 12)

        addSubview(inputTextField)
        inputTextField.frame = CGRect(x: 0, y: 19, width: boundsWidth, height: 20)
        inputTextField.placeholder = type == .Email ? "Email" : "Password"
        inputTextField.isSecureTextEntry = type == .Password
        inputTextField.textAlignment = .left
        
        addSubview(bottomLineView)
        bottomLineView.backgroundColor = .lightGray
        bottomLineView.frame = CGRect(x: 0, y: boundsHeight, width: boundsWidth, height: 1)
    }

    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let t = Int(textField.text?.characters.count) {
//            
//        }
//        
//        if textField.text?.characters.count > 0 {
//            topLabel.textColor = UIColor.blue
//        }
        
        if let text = textField.text, text.characters.count > 0 {
            inputTextField.textColor = .blue
        }
        
//        let t: String? = "String"
//        if let str = t, str.characters.count > 0 {
//            print("Test")
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.characters.count > 0 {
//            inputTextField.textColor = UIColor.lightGray
//        } else {
//            UIView.animate(withDuration: 0.25, animations: { 
//                self.inputTextField.alpha = 0
//            }, completion: { done in
//                self.inputTextField.textColor = UIColor.blue
//                
//            })
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        return false
    }
}
