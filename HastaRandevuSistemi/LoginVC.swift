//
//  LoginVC.swift
//  HastaRandevuSistemi
//
//  Created by Berivan on 27.10.2021.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userIdTF: UITextField!
    @IBOutlet weak var userPassTF: UITextField!
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login(_ sender: UIButton) {
        let userId = userIdTF.text ?? ""
        let userPass = userPassTF.text ?? ""
        
        if userId == "" || userPass == "" {
            let alert = UIAlertController(title: "Hata", message: "Tc veya şifre boş olamaz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            appDelegate.db.child("users").child(userId).getData(completion: { error, snapshot in
                let value = snapshot.value as? NSDictionary
                if value == nil {
                    let alert = UIAlertController(title: "Hata", message: "Kullanıcı bulunamadı!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let remoteUserType = value?["user_type"] as? Int ?? -1
                    let remoteUserPass = value?["password"] as? String ?? ""
                    
                    if userPass != remoteUserPass {
                        let alert = UIAlertController(title: "Hata", message: "Şifre hatalı!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.appDelegate.userTc = userId
                        switch remoteUserType {
                        case 0:
                            self.performSegue(withIdentifier: "goToDoctorMain", sender: nil)
                        case 1:
                            self.performSegue(withIdentifier: "goToPatientMain", sender: nil)
                        default:
                            debugPrint("Unknown user_type!")
                        }
                    }
                }
            })
        }
    }
}
