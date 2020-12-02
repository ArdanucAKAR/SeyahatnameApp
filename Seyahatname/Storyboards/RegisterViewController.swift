//
//  RegisterViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Firebase
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPasswordAgain: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        if txtEmail.text != "" && txtPassword.text != "" {
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { _, error in
                if error != nil {
                    self.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata")
                }
                else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        }
        else {
            Alert(title: "Hata", message: "Tüm Alanlar Doldurulmalıdır")
        }
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }

    func Alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(btnOk)
        present(alert, animated: true, completion: nil)
    }
}
