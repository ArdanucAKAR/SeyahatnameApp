//
//  SettingsViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import Firebase
import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogoutClick(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch {
            present(Notify.Alert(title: "Hata", message: "Bilinmeyen Hata"), animated: true, completion: nil)
            
        }
    }
}
