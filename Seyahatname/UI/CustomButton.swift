//
//  CustomButton.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 29.11.2020.
//

import Foundation
import UIKit

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor = UIColor.black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
}
