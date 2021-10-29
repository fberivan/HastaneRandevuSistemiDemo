//
//  MainVC.swift
//  HastaRandevuSistemi
//
//  Created by Berivan on 28.10.2021.
//

import UIKit

class PatientMainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var doktorSec: UIPickerView!
    var doctors: [Doctor] = []
    @IBOutlet weak var hourEight: UIButton!
    @IBOutlet weak var hourNine: UIButton!
    @IBOutlet weak var hourTen: UIButton!
    @IBOutlet weak var hourEleven: UIButton!
    @IBOutlet weak var hourOne: UIButton!
    @IBOutlet weak var hourTwo: UIButton!
    @IBOutlet weak var hourThree: UIButton!
    @IBOutlet weak var hourFour: UIButton!
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        appDelegate.db.child("users").getData(completion: { error, snapshot in
            if let users = snapshot.value as? NSDictionary {
                for (key, value) in users {
                    if let user = value as? NSDictionary {
                        if let userType = user["user_type"] as? Int {
                            if userType == 0 {
                                let username = user["username"] as! String
                                let tc = key as! String
                                let doctor = Doctor(tc: tc, name: username)
                                self.doctors.append(doctor)
                            }
                        }
                    }
                }
                self.onDoctorSelected(doctor: self.doctors[0])
                self.doktorSec.delegate = self
                self.doktorSec.dataSource = self
            }
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return doctors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return doctors[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onDoctorSelected(doctor: doctors[row])
    }
    
    func onDoctorSelected(doctor: Doctor) {
        appDelegate.db.child("users").child(doctor.tc).child("dates")
            .getData(completion: { error, snapshot in
                if (snapshot.value as? NSDictionary) != nil {
                    self.hourEight.isEnabled = !snapshot.hasChild("08:00")

                    self.hourNine.isEnabled = !snapshot.hasChild("09:00")

                    self.hourTen.isEnabled = !snapshot.hasChild("10:00")
                    
                    self.hourEleven.isEnabled = !snapshot.hasChild("11:00")
                    
                    self.hourOne.isEnabled = !snapshot.hasChild("13:00")
                    
                    self.hourTwo.isEnabled = !snapshot.hasChild("14:00")
                    
                    self.hourThree.isEnabled = !snapshot.hasChild("15:00")
                    
                    self.hourFour.isEnabled = !snapshot.hasChild("16:00")
                } else {
                    self.hourEight.isEnabled = true

                    self.hourNine.isEnabled = true

                    self.hourTen.isEnabled = true
                    
                    self.hourEleven.isEnabled = true
                    
                    self.hourOne.isEnabled = true
                    
                    self.hourTwo.isEnabled = true
                    
                    self.hourThree.isEnabled = true
                    
                    self.hourFour.isEnabled = true
                }
        })
    }
    @IBAction func onHourEightClick(_ sender: UIButton) {
        saveDate(date: "08:00")
    }
    @IBAction func onHourNineClick(_ sender: UIButton) {
        saveDate(date: "09:00")
    }
    @IBAction func onHourTenClick(_ sender: UIButton) {
        saveDate(date: "10:00")
    }
    @IBAction func onHourElevenClick(_ sender: UIButton) {
        saveDate(date: "11:00")
    }
    @IBAction func onHourOneClick(_ sender: UIButton) {
        saveDate(date: "13:00")
    }
    @IBAction func onHourTwoClick(_ sender: UIButton) {
        saveDate(date: "14:00")
    }
    @IBAction func onHourThreeClick(_ sender: UIButton) {
        saveDate(date: "15:00")
    }
    @IBAction func onHourFourClick(_ sender: UIButton) {
        saveDate(date: "16:00")
    }
    
    func saveDate(date: String) {
        let index = doktorSec.selectedRow(inComponent: 0)
        self.appDelegate.db.child("users").child(doctors[index].tc).child("dates").updateChildValues([
            date: appDelegate.userTc
        ])
        onDoctorSelected(doctor: doctors[index])
    }
}
