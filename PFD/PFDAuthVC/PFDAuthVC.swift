//
//  PFDAuthVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDAuthVC: UIViewController , NVActivityIndicatorViewable {
  
    @IBOutlet weak var txtEmail: UITextField!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.text = "mubassirhayat@gmail.com"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation() {
            if self.txtEmail.text!.count == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC1") as? SignUpVC1
                self.navigationController?.pushViewController(vc!, animated: true)
            
            } else {

                
                let loginParam =  [ "email"         : txtEmail.text!,
                                  ] as [String : Any]
                
                startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGINAUTH, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
                    let responseObj = response as! UserResponse
                    self.stopAnimating()

                    if responseObj.authOfLogin?.login == true {
                       
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDSignInVC") as? PFDSignInVC
                        vc?.email = self.txtEmail.text
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                        
                    }else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC1") as? SignUpVC1
                        vc?.email = self.txtEmail.text
                        self.navigationController?.pushViewController(vc!, animated: true)

                        
                    }
                    
                }, fail: { (error) in
                    self.stopAnimating()

                }, showHUD: true)
                
            }
                
            }
            
            
        }
        
        
    
    
    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count == 0 {
            validInput = true
            self.txtEmail.becomeFirstResponder()
            
        }
            
        else  if !WAShareHelper.isValidEmail(email: txtEmail.text!) {
            validInput = false
            
            self.txtEmail.becomeFirstResponder()
            
            self.showAlert(title: "PFD", message: kValidationEmailInvalidInput, controller: self)
            
//            self.showCustomPop(popMessage: kValidationEmailInvalidInput , imageName: "lightbulb")
            
        }
        return validInput
    }
    
    
    
}
