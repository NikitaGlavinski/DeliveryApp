//
//  UIViewExtension.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/21/21.
//

import UIKit

extension UIView {
    
    func loadFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
