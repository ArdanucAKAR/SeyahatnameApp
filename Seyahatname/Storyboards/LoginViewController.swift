//
//  ViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 26.11.2020.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var txtUsername: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
}