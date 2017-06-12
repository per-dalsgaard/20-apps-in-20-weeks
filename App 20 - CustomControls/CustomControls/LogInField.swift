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
        print("Bounds height: \(boundsHeight)")
        addSubview(topLabel)
        topLabel.frame = CGRect(x: 0, y: boundsHeight / 2, width: boundsWidth, height: 20)
        topLabel.alpha = 0
        topLabel.text = type == .Email ? "Email" : "Password"
        topLabel.textAlignment = .left
        topLabel.textColor = .blue
        topLabel.font = UIFont.systemFont(ofSize: 12)

        addSubview(inputTextField)
        inputTextField.frame = CGRect(x: 0, y: 19, width: boundsWidth, height: 20)
        inputTextField.delegate = self
        inputTextField.placeholder = type == .Email ? "Email" : "Password"
        inputTextField.isSecureTextEntry = type == .Password
        inputTextField.textAlignment = .left
        
        inputTextField.addTarget(self, action: #selector(LogInField.checkTopLabel(_:)), for: .editingChanged)
        
        addSubview(bottomLineView)
        bottomLineView.backgroundColor = .lightGray
        bottomLineView.frame = CGRect(x: 0, y: boundsHeight, width: boundsWidth, height: 1)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, !text.characters.isEmpty {
            topLabel.textColor = .blue
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.characters.isEmpty {
            topLabel.textColor = UIColor.lightGray
        } else {
            UIView.animate(withDuration: 0.25, animations: { 
                self.topLabel.alpha = 0
            }, completion: { done in
                self.topLabel.textColor = UIColor.blue
                self.topLabel.frame = CGRect(x: 0, y: self.boundsHeight / 2, width: self.boundsWidth, height: 1)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTextField.endEditing(true)
        return false
    }
    
    func checkTopLabel(_ sender: UITextField!) {
        print("Check!!")
        guard let text = sender.text, !text.characters.isEmpty else { return }
        
        UIView.animate(withDuration: 0.5) { 
            self.topLabel.alpha = 1
            self.topLabel.frame = CGRect(x: 0, y: 2, width: self.boundsWidth, height: 20)
        }
    }
}
