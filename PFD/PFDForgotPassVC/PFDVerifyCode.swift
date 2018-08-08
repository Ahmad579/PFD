//
//  PFDVerifyCode.swift
//  PFD
//
//  Created by Ahmed Durrani on 10/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

import NVActivityIndicatorView

class PFDVerifyCode: UIViewController , NVActivityIndicatorViewable  , UITextFieldDelegate {
   
    @IBOutlet var tfOneText: UITextField!
    @IBOutlet var tfTwoTxt: UITextField!
    @IBOutlet var tfThirdTxt: UITextField!
    @IBOutlet var tfFouthTxt: UITextField!
    @IBOutlet var tfFifthTxt: UITextField!
    @IBOutlet var tfSixthTxt: UITextField!
    let size = CGSize(width: 60, height: 60)
    var email   : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnVerify_Pressed(_ sender: UIButton) {
        var codeEnter = tfOneText.text!
        codeEnter += tfTwoTxt.text!
        codeEnter += tfThirdTxt.text!
        codeEnter += tfFouthTxt.text!
        codeEnter += tfFifthTxt.text!
        codeEnter += tfSixthTxt.text!
        
        
        let loginParam =  [ "email"                      : email!,
                            "verification_code"          : codeEnter
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: VERIFY_CODE, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            self.stopAnimating()
            
            if responseObj.response_code == 200 {
                self.navigationController?.popToRootViewController(animated: true)
                
            }else {
                self.showAlert(title: "PFD", message: responseObj.message! , controller: self)
                
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
    }
    
    @objc func checkTF() {
        if (tfOneText.text?.count == 1) {
            tfTwoTxt.becomeFirstResponder()
        }
        if (tfTwoTxt.text?.count == 1) {
            tfThirdTxt.becomeFirstResponder()
        }
        if (tfThirdTxt.text?.count == 1) {
            tfFouthTxt.becomeFirstResponder()
        }
        if (tfFouthTxt.text?.count == 1) {
            tfFifthTxt.becomeFirstResponder()
        }
        if (tfFifthTxt.text?.count == 1) {
            tfSixthTxt.becomeFirstResponder()
        }
        if (tfSixthTxt.text?.count == 1) {
            tfSixthTxt.resignFirstResponder()
        }
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        if textField == tfOneText {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfTwoTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfThirdTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfFouthTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfFifthTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        else if textField == tfSixthTxt {
            if (textField.text?.count)! >= kPasswordRequiredLength && range.length == 0 {
                return false
            }
            perform(#selector(self.checkTF), with: nil, afterDelay: 0.1)
            return true
        }
        
        
        return true
    }

}
