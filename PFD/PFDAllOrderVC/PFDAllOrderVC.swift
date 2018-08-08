//
//  PFDAllOrderVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 20/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDAllOrderVC: UIViewController , NVActivityIndicatorViewable {
    
    let size = CGSize(width: 60, height: 60)
    
    var responseObj: UserResponse?
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PFDOrderCell", bundle: nil), forCellReuseIdentifier: "PFDOrderCell")
        //        tblView.delegate = self
        //        tblView.dataSource = self
        //        tblView.reloadData()
        tblView.tableFooterView = UIView(frame: .zero)
        getAllOrder()
        
    }
    
    func getAllOrder() {
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        
        let serviceURL =  ALLORDERLIST + "?api_token=\(apiToken!)"
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Restaurant List", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = (response as! UserResponse)
            if  self.responseObj?.response_code == 200 {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
            else {
                
                
            }
        }) { (error) in
            self.stopAnimating()
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension PFDAllOrderVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.orderList?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Restaurant."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //        return 10
        return (self.responseObj?.orderList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFDOrderCell", for: indexPath) as? PFDOrderCell
        
        UtilityHelper.setViewBorder((cell?.viewOfOrder)!, withWidth: 1.0, andColor: UIColor(red: 238/255.0, green: 117/255.0, blue: 59/255.0, alpha: 1.0))
        cell?.lblRestaurentName.text = self.responseObj?.orderList![indexPath.row].restaurent?.name
        let orderNumber = self.responseObj?.orderList![indexPath.row].id
        cell?.lblOrderNo.text = "Order No.\(orderNumber!)"
        cell?.lblDate.text = self.responseObj?.orderList![indexPath.row].order_date
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDOrderDetailVC") as? PFDOrderDetailVC
        //      vc?.menuList = self.responseObj?.orderList![indexPath.row].items
        vc?.orderDetail = self.responseObj?.orderList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 117.0
    }
    
    
    
}

