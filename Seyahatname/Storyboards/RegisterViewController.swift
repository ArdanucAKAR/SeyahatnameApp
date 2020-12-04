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
                    self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
            }
        } else {
            present(Notify.Alert(title: "Hata", message: "Tüm Alanlar Doldurulmalıdır."), animated: true, completion: nil)
        }
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
}
