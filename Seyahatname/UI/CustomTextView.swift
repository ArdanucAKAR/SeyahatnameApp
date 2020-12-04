//
//  CustomTextView.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 4.12.2020.
//

import Foundation
import UIKit

@IBDesignable
class CustomTextView: UITextView {
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
}
