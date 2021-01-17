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

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        if txtUsername.text != "", txtPassword.text != "" {
            if isValidEmail(txtUsername.text!)==true {
                Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { _, error in
                    if error != nil {
                        self.present(Notify.Alert(title: "Hata", message: error?.localizedDescription ?? "Bilinmeyen Hata"), animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    }
                }
            }else{
                present(Notify.Alert(title: "Uyarı", message: "Lütfen geçerli email adresi giriniz."), animated: true, completion: nil)
            }
        } else {
            present(Notify.Alert(title: "Hata", message: "Tüm alanlar doldurulmalıdır."), animated: true, completion: nil)
        }
    }

    @IBAction func btnRegisterClick(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
}
