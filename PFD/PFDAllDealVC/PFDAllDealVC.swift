//
//  PFDAllDealVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 20/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDAllDealVC: UIViewController , NVActivityIndicatorViewable {
    
    let size = CGSize(width: 60, height: 60)
    
    var responseObj: UserResponse?
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PFDDealCell", bundle: nil), forCellReuseIdentifier: "PFDDealCell")
//        tblView.delegate = self
//        tblView.dataSource = self
//        tblView.reloadData()
        tblView.tableFooterView = UIView(frame: .zero)
        getAllDeal()
//        getAllLocalRestaurant()

    }
    
    func getAllDeal() {
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        
        let serviceURL =  ALLDEALLIST + "?api_token=\(apiToken!)"

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
                self.showAlert(title: "PFD", message: (self.responseObj?.message!)!, controller: self)
                
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

extension PFDAllDealVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.dealList?.isEmpty == false {
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
        
        //            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.dealList?.count)!
        //        return (self.responseObj?.listOfRestaurant?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFDDealCell", for: indexPath) as? PFDDealCell
        let imageName = self.responseObj?.dealList?[indexPath.row].image
        let restaurentImage = imageName?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:restaurentImage! , imageView: (cell?.imgOFRestaurent!)!, placeHolder: "image_placeholder")
        cell?.lblRestaurnetName.text = self.responseObj?.dealList?[indexPath.row].restaurent?.name
        cell?.lblDealType.text = self.responseObj?.dealList?[indexPath.row].deal_type
        cell?.lblWeeklyOrMonthly.text = self.responseObj?.dealList?[indexPath.row].deal_name
        let dealPR = self.responseObj?.dealList?[indexPath.row].deal_price
        
        cell?.lblPriceOfDeal.text = "PKR \(dealPR!)"
        cell?.lblDescription.text = self.responseObj?.dealList?[indexPath.row].deal_description
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDDealDetailVC") as? PFDDealDetailVC
        vc?.dealDetail = self.responseObj?.dealList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 323.0
    }
    
    
    
}


