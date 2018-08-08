//
//  PFDProfileSettingsVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 21/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDProfileSettingsVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = UserDefaults.standard.string(forKey: "email")
        let name = UserDefaults.standard.string(forKey: "name")
        let phoneNumber = UserDefaults.standard.string(forKey: "phone")
        
        txtEmail.text = email
        txtName.text = name
        txtMobileNum.text = phoneNumber
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveinfo_Pressed(_ sender: UIButton) {
        
    }
    
   
    @IBAction func btnChangePassword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDChangePasswordVC") as? PFDChangePasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
