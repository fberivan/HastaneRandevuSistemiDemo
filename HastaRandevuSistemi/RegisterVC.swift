//
//  RegisterVC.swift
//  HastaRandevuSistemi
//
//  Created by Berivan on 27.10.2021.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var userTypeSC: UISegmentedControl!
    @IBOutlet weak var userIdTF: UITextField!
    @IBOutlet weak var userPassTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func register(_ sender: UIButton) {
        let userType = userTypeSC.selectedSegmentIndex
        let userId = userIdTF.text ?? ""
        let userPass = userPassTF.text ?? ""
        let userName = userNameTF.text ?? ""
        
        if userId == "" || userPass == "" {
            let alert = UIAlertController(title: "Hata", message: "Tc veya şifre boş olamaz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            appDelegate.db.child("users").getData(completion: { error, snapshot in
                if snapshot.hasChild(userId) {
                    let alert = UIAlertController(title: "Hata", message: "Bu TC ile kayıtlı bir kullanıcı zaten var!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.appDelegate.db.child("users").child(userId).setValue([
                        "password": userPass,
                        "user_type": userType,
                        "username": userName
                    ])
                    let alert = UIAlertController(title: "Başarılı", message: "Kullanıcı kayıt edildi!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

}
