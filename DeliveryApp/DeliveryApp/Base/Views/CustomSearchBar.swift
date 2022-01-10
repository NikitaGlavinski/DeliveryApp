//
//  CustomSearchBar.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import UIKit

protocol CustomSearchBarDelegate: AnyObject {
    func textDidChenged(text: String, searchBar: CustomSearchBar)
}

@IBDesignable
class CustomSearchBar: UIView {
    
    @IBInspectable var placeholder: String = "Search on foodly"
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    weak var delegate: CustomSearchBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadFromNib(nibName: "CustomSearchBar") else { return }
        view.frame = bounds
        addSubview(view)

        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5.0

        textField.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.text = placeholder
    }

}

extension CustomSearchBar: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        placeholderLabel.isHidden = textField.text?.isEmpty == true ? false : true
        delegate.textDidChenged(text: textField.text ?? "", searchBar: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
