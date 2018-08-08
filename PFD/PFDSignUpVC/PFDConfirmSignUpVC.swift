//
//  PFDConfirmSignUpVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDConfirmSignUpVC: UIViewController , NVActivityIndicatorViewable {
    
    var txtEmail : String?
    var pass     : String?
    
    @IBOutlet weak var txtFirtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()

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

        var deviceToken =  UserDefaults.standard.value(forKey: "device_token") as? String
        
        if deviceToken == nil {
            deviceToken = "-1"
        }
        let firstNum = "0"
        let phoneNum  =  "\(firstNum)\(txtPhoneNum.text!)"
        let fullName = "\(txtFirtName.text!) \(txtLastName.text!)"
        let loginParam =  [ "email"         : txtEmail!,
                            "name"          : fullName ,
                            "password"      : pass! ,
                            "device_type"   : "iOS" ,
                            "device_token"  : deviceToken! ,
                            "latitude"      : DEVICE_LAT ,
                            "longitude"     : DEVICE_LONG ,
                            "phone"         : phoneNum
            
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            self.stopAnimating()
            if responseObj.response_code == 200 {
                
                UserDefaults.standard.set(responseObj.data?.email , forKey: "email")
                self.showAlertViewWithTitle(title: "PFD", message: responseObj.message!, dismissCompletion: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDCodeConfirmationVC") as? PFDCodeConfirmationVC
                    
                    self.navigationController?.pushViewController(vc!, animated: true)
                })
              
                
            }else {
                self.showAlertViewWithTitle(title: "PFD", message: responseObj.message!, dismissCompletion: {
                    self.navigationController?.popViewController(animated: true)
                })

            }
            
        }, fail: { (error) in
            self.stopAnimating()
            
        }, showHUD: true)
        }
    }
    
    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if  self.txtFirtName.text!.count ==  0 {
            validInput = false
            self.showAlert(title: "PFD", message: kValidationMessageMissingInput, controller: self)
            
        }
        else if   self.txtLastName.text!.count ==  0 {
            validInput = false
            self.showAlert(title: "PFD", message: kValidationMessageMissingInput, controller: self)
            
        }
        
        else if self.txtPhoneNum.text!.count == 0{
            validInput = false
            self.txtPhoneNum.becomeFirstResponder()
            self.showAlert(title: "PFD", message: kValidationMessageMissingInput, controller: self)

        }

            
       else if self.txtPhoneNum.text!.count <= kUserNameRequiredLengthForPhone {
            validInput = false
            self.txtPhoneNum.becomeFirstResponder()
            self.showAlert(title: "PFD", message: kValidationMessageMissingInputPhone, controller: self)
        }
        
        return validInput
    }
    
}


