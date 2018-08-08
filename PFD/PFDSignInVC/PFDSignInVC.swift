//
//  PFDSignInVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDSignInVC: UIViewController , NVActivityIndicatorViewable {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!

    let size = CGSize(width: 60, height: 60)
    var email : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = email
        txtPass.text  = "123456"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnShow_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            self.txtPass.isSecureTextEntry = false
        } else {
            self.txtPass.isSecureTextEntry = true

        }
    }

    
    @IBAction func btnForPassword_PRessed(_ sender: UIButton) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDForgotPassVC") as? PFDForgotPassVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation() {
         
                //              LOGINAUTH
            
            var deviceToken =  UserDefaults.standard.value(forKey: "device_token") as? String
            
            if deviceToken == nil {
                deviceToken = "-1"
            }
                let loginParam =  [ "email"         : txtEmail.text!,
                                    "password"      : txtPass.text! ,
                                    "device_type"   : "iOS" ,
                                    "device_token"  : deviceToken! ,
                                    "latitude"      : DEVICE_LAT ,
                                    "longitude"     : DEVICE_LONG
                                    ] as [String : Any]
                
                startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
                
                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
                    let responseObj = response as! UserResponse
                    self.stopAnimating()
                    
                    if responseObj.response_code == 200 {
                        
                        UserDefaults.standard.set(responseObj.data?.name             , forKey: "name")
                        UserDefaults.standard.set(responseObj.data?.email            , forKey: "email")
                        UserDefaults.standard.set(responseObj.data?.id               , forKey: "id")
                        UserDefaults.standard.set(responseObj.data?.api_token        , forKey: "api_token")
                        UserDefaults.standard.set(responseObj.data?.is_verified      , forKey: "is_verified")
                        UserDefaults.standard.set(responseObj.data?.is_accepted      , forKey: "is_accepted")
                        UserDefaults.standard.set(responseObj.data?.address          , forKey: "address")
                        UserDefaults.standard.set(responseObj.data?.lat              , forKey: "latitude")
                        UserDefaults.standard.set(responseObj.data?.lng              , forKey: "longitude")
                        UserDefaults.standard.set(responseObj.data?.phone            , forKey: "phone")
                        let story = UIStoryboard(name: "Home", bundle: nil)
                        let vc = story.instantiateViewController(withIdentifier: "PFDHomeTabBarVC")
                        let nav = UINavigationController(rootViewController: vc)
                        nav.isNavigationBarHidden = true
                        UIApplication.shared.keyWindow?.rootViewController = nav
                        
                    }else {
                        
                        
                    }
                    
                }, fail: { (error) in
                    self.stopAnimating()
                    
                }, showHUD: true)
                
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
