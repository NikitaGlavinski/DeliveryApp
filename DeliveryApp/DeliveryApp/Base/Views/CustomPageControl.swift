//
//  CustomPageControl.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

@IBDesignable
class CustomPageControl: UIView {
    
    @IBInspectable var pagesCount: Int = 0
    @IBInspectable var selectionColor: UIColor = UIColor()
    @IBInspectable var secondaryColor: UIColor = UIColor()
    
    private let standardColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1)
    
    private var views = [UIView]()
    private var currentIndex: Int = 0
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView(selectedIndex: currentIndex)
    }
    
    func configureView(selectedIndex: Int) {
        currentIndex = selectedIndex
        updateView(selectedIndex: selectedIndex)
    }
    
    private func updateView(selectedIndex: Int) {
        createViews(selectedIndex: selectedIndex)
        configStackView()
        setupUI()
    }
    
    private func configStackView() {
        stackView.arrangedSubviews.forEach { arrangeView in
            self.stackView.removeArrangedSubview(arrangeView)
            arrangeView.removeFromSuperview()
        }
        views.forEach { arrangeView in
            self.stackView.addArrangedSubview(arrangeView)
        }
    }
    
    private func createViews(selectedIndex: Int) {
        views.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for index in 0..<pagesCount {
            let view = UIView()
            view.layer.cornerRadius = 3
            view.backgroundColor = index == currentIndex ? selectionColor : secondaryColor
            views.append(view)
        }
    }
    
    private func setupUI() {
        stackView.frame = bounds
        addSubview(stackView)
    }
}
