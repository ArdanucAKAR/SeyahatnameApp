//
//  CustomTextField.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 29.11.2020.
//

import Foundation
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    @IBInspectable var placeholderColor: UIColor = UIColor.black {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: "",
                                                            attributes: [NSAttributedString.Key.foregroundColor: self.placeholderColor])
        }
    }
}
