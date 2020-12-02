//
//  SettingsViewController.swift
//  Seyahatname
//
//  Created by Ardanuc AKAR on 2.12.2020.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogoutClick(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
}
