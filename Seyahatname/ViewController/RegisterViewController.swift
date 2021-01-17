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

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        if txtEmail.text != "", txtPassword.text != "" {
            if isValidEmail(txtEmail.text!) {
                Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { _, error in
                    if error != nil {
                        self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    }
                }
            } else {
                present(Notify.Alert(title: "Uyarı", message: "Lütfen geçerli email adresi giriniz."), animated: true, completion: nil)
            }
        } else {
            present(Notify.Alert(title: "Hata", message: "Tüm alanlar doldurulmalıdır."), animated: true, completion: nil)
        }
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
}
