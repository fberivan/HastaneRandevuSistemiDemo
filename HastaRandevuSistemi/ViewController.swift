//
//  ViewController.swift
//  HastaRandevuSistemi
//
//  Created by Berivan on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "goToLogin", sender: nil)
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: nil)
    }
}

