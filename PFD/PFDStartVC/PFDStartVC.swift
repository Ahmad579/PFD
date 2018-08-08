//
//  PFDStartVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDStartVC: UIViewController {
    
    @IBOutlet weak var btnEmail: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        WAShareHelper.setBorderAndCornerRadius(layer: btnEmail.layer, width: 2.0, radius: 0.0, color: UIColor.white)
        let userID = UserDefaults.standard.string(forKey: "id")
        
        if userID == nil  {
            
        } else {
            let story = UIStoryboard(name: "Home", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "PFDHomeTabBarVC")
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController = nav
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnContinueWithFacebook_Pressed(_ sender: UIButton) {
    
    }
    
    @IBAction func btnContinueWithEmail_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDAuthVC") as? PFDAuthVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }


}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
