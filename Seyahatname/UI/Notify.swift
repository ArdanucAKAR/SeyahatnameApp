//
//  Notify.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Foundation
import UIKit

class Notify {
    static func Alert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(btnOk)
        
        return alert
    }
}
