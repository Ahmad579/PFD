//
//  PFDForgotPassVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 10/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDForgotPassVC: UIViewController , NVActivityIndicatorViewable {
    
    @IBOutlet weak var txtEmail: UITextField!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation() {
                let loginParam =  [ "email"         : txtEmail.text!,
                                    ] as [String : Any]
                
                startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
                
                WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FORGOTPASSWORD_API, isLoaderShow: true, serviceType: "Forgot Password", modelType: UserResponse.self, success: { (response) in
                    let responseObj = response as! UserResponse
                    self.stopAnimating()
                    
                    if responseObj.response_code == 200 {
                        
                        self.showAlertViewWithTitle(title: "PFD", message: responseObj.message!, dismissCompletion: {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDVerifyCode") as? PFDVerifyCode
                            vc?.email = self.txtEmail.text!
                            self.navigationController?.pushViewController(vc!, animated: true)

                        })
                        
                        
                    }else {
                        self.showAlert(title: "PFD", message: responseObj.message!, controller: self)
                        
                        
                    }
                    
                }, fail: { (error) in
                    self.stopAnimating()
                    
                }, showHUD: true)
                
            }
            
        
        
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count == 0 {
            validInput = false
            self.showAlert(title: "PFD", message: kValidationMessageMissingInput, controller: self)

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
