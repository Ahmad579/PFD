//
//  PFDProfileVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 20/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDProfileVC: UIViewController {
    let profileOption = ["Profile Settings","Contact Us","List your restaurant" , "Like us on facebook", "FAQs", "Term & Policy"]
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PFDProfileCell", bundle: nil), forCellReuseIdentifier: "PFDProfileCell")
        btnSignOut.layer.shadowOpacity = 0.5
        btnSignOut.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btnSignOut.layer.shadowRadius = 5.0
        btnSignOut.layer.shadowColor = UIColor(red: 236/255.0, green: 71/255.0, blue: 73/255.0, alpha: 1.0).cgColor
      
        tblView.tableFooterView = UIView(frame: .zero)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignout_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "user_token")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(nil  , forKey : "email")
        UIApplication.shared.keyWindow?.rootViewController = vc

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   


  
}

extension PFDProfileVC: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFDProfileCell", for: indexPath) as? PFDProfileCell
        cell?.lblProfileName?.text = profileOption[indexPath.row]
//        let imageName = images[indexPath.row]
//        cell?.imageView?.image = UIImage(named: imageName)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//            PFDProfileSettingsVC
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDProfileSettingsVC") as? PFDProfileSettingsVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
    
}
