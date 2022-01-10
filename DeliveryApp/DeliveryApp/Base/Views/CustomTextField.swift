//
//  CustomTextField.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/21/21.
//

import UIKit

@IBDesignable
class CustomTextField: UIView {
    
    @IBInspectable var placeHolder: String = ""
    @IBInspectable var isSecure: Bool = false
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secureButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadFromNib(nibName: "CustomTextField") else { return }
        view.frame = bounds
        addSubview(view)

        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5.0
        
        textField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.text = placeHolder
        textField.isSecureTextEntry = isSecure
        secureButton.isHidden = !isSecure
    }
    
    @IBAction func changeSecure(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        if !textField.isSecureTextEntry {
            secureButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            secureButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        label.isHidden = (textField.text ?? "") == "" ? false : true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
