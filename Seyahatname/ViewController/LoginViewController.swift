//
//  ViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 26.11.2020.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        if txtUsername.text != "", txtPassword.text != "" {
            Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { _, error in
                if error != nil {
                    self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        } else {
            present(Notify.Alert(title: "Hata", message: "Tüm Alanlar Doldurulmalıdır."), animated: true, completion: nil)
        }
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
}
