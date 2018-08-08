//
//  SignUpVC1.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class SignUpVC1: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    var email : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnShow_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            self.txtPass.isSecureTextEntry = false
        } else {
            self.txtPass.isSecureTextEntry = true
            
        }
    }

    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDConfirmSignUpVC") as? PFDConfirmSignUpVC
            vc?.txtEmail = txtEmail.text!
            vc?.pass = txtPass.text!
            self.navigationController?.pushViewController(vc!, animated: true)

        }
        
        

    }
    
    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count < kUserNameRequiredLength {
            validInput = false
            self.txtEmail.becomeFirstResponder()
            self.showAlert(title: "PFD", message: kValidationMessageMissingInput, controller: self)
            
        }
            
        else  if !WAShareHelper.isValidEmail(email: txtEmail.text!) {
            validInput = false
            
            self.txtEmail.becomeFirstResponder()
            
            self.showAlert(title: "PFD", message: kValidationEmailInvalidInput, controller: self)
            
            
        }
            
            
        else if   self.txtPass.text!.count ==  0 {
            validInput = false
            self.showAlert(title: "PFD", message: KValidationPassword, controller: self)
            
        }
        else if   self.txtPass.text!.count < kPasswordRequiredLength {
            validInput = false
            self.txtPass.becomeFirstResponder()
            self.showAlert(title: "PFD", message: KValidationPassword, controller: self)
            
        }
        return validInput
    }
    
}
