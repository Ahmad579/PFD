//
//  PFDAllRestaurantVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDAllRestaurantVC: UIViewController , NVActivityIndicatorViewable {
  
    let size = CGSize(width: 60, height: 60)

    var responseObj: UserResponse?
    var getAllDeal: UserResponse?
    var filters   : [AllRestaurantList]?

    @IBOutlet var searchBar: UISearchBar!
    var searchActive : Bool = false

    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PFRestaurantCell", bundle: nil), forCellReuseIdentifier: "PFRestaurantCell")
        tblView.register(UINib(nibName: "SearchRestaurentCell", bundle: nil), forCellReuseIdentifier: "SearchRestaurentCell")
        
        getAllLocalRestaurant()
    }
    
    func getAllLocalRestaurant() {
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        
        let serviceURL =  RESTAURANTLIST + "?api_token=\(apiToken!)"

//        let serviceURL =  RESTAURANTLIST + "?api_token=\(localUserData.api_token!)"
         startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Restaurant List", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()

            self.responseObj = (response as! UserResponse)
            if  self.responseObj?.response_code == 200 {
//                self.tblView.delegate = self
//                self.tblView.dataSource = self
//                self.tblView.reloadData()
                self.getAllDealForRestaurent()
            }
            else {
                
                
            }
        }) { (error) in
            self.stopAnimating()

            
        }
    }
    
    func getAllDealForRestaurent() {
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        
        let serviceURL =  ALLDEALLIST + "?api_token=\(apiToken!)"
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Restaurant List", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.getAllDeal = (response as! UserResponse)
            if  self.getAllDeal?.response_code == 200 {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
            else {
                self.showAlert(title: "PFD", message: (self.getAllDeal?.message!)!, controller: self)
                
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

extension PFDAllRestaurantVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        var numOfSections: Int = 0
//            if  self.responseObj?.listOfRestaurant?.isEmpty == false {
//                numOfSections = 1
//                tblView.backgroundView = nil
//            }
//            else {
//                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
//                noDataLabel.numberOfLines = 10
//                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
//                    noDataLabel.font = aSize
//                }
//                noDataLabel.text = "There are currently no Restaurant."
//                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
//                noDataLabel.textAlignment = .center
//                tblView.backgroundView = noDataLabel
//                tblView.separatorStyle = .none
//            }
//            return numOfSections

        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
         else if section == 1 {
            return 1
        } else {
            if searchActive == true {
                    return (self.filters?.count)!
            } else {
                return (self.responseObj?.listOfRestaurant?.count)!

            }

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRestaurentCell", for: indexPath) as? SearchRestaurentCell
            if searchActive == true {
                cell?.searchBar.delegate = self
                self.searchBar.becomeFirstResponder()

            } else {
                searchBar = cell?.searchBar
                cell?.searchBar.placeholder = "Search"
                cell?.searchBar.delegate = self
//                self.searchBar.becomeFirstResponder()


            }
            
            return cell!

        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurentCell", for: indexPath) as? RestaurentCell
            let coutOfItem = self.getAllDeal?.dealList?.count
            cell?.lblNumberOfItem.text = "1/\(coutOfItem!)"
            cell?.featureItem = self.getAllDeal
            return cell!

        } else {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PFRestaurantCell", for: indexPath) as? PFRestaurantCell
            if indexPath.row == 0 {
                cell?.lblBrowse.isHidden = false
            } else {
                cell?.lblBrowse.isHidden = true

            }
            if searchActive == true {
                cell?.lblRetaurantName.text = self.filters?[indexPath.row].name
                cell?.lblDeliveryFee.text = " RS 150"
                //        cell?.ratingView.rating = 4.0
                cell?.ratingView.rating = 3.00000
                let imageName = self.filters?[indexPath.row].image_url
                let restaurentImage = imageName?.replacingOccurrences(of: " ", with: "%20")
                WAShareHelper.loadImage(urlstring:restaurentImage! , imageView: (cell?.imgOfrestaurant!)!, placeHolder: "image_placeholder")
                cell?.lblOpensTill.text = "Opens till"
                cell?.lblTiming.text = self.filters?[indexPath.row].closing_time

            } else {
                cell?.lblRetaurantName.text = self.responseObj?.listOfRestaurant?[indexPath.row].name
                cell?.lblDeliveryFee.text = " RS 150"
                //        cell?.ratingView.rating = 4.0
                cell?.ratingView.rating = 3.00000
                let imageName = self.responseObj?.listOfRestaurant?[indexPath.row].image_url
                let restaurentImage = imageName?.replacingOccurrences(of: " ", with: "%20")
                WAShareHelper.loadImage(urlstring:restaurentImage! , imageView: (cell?.imgOfrestaurant!)!, placeHolder: "image_placeholder")
                cell?.lblOpensTill.text = "Opens till"
                cell?.lblTiming.text = self.responseObj?.listOfRestaurant?[indexPath.row].closing_time

            }
            return cell!
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDRestaurantDetailVC") as? PFDRestaurantDetailVC
            if  searchActive == true  {
                vc?.restaurentInfo = self.filters![indexPath.row]
            } else {
                vc?.restaurentInfo = self.responseObj?.listOfRestaurant![indexPath.row]
                
            }
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
      
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 151.0
        }
       else  if indexPath.section == 1 {
            return 333.0
        } else {
            if indexPath.row == 0 {
                return 300.0

            }else {
                return 300.0

            }

        }
    }
    
    

}

extension PFDAllRestaurantVC : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = ""
        searchBar.placeholder = "Search"
        searchBar.resignFirstResponder()
        self.tblView.reloadData()
    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                self.searchBar.showsCancelButton = true
                searchActive = true
        
//                searchBar.becomeFirstResponder()
                filters = self.responseObj?.listOfRestaurant?.filter { ($0.name?.lowercased().contains(searchText.lowercased()))! }
                self.tblView.reloadData()

    
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        searchActive = false
//        self.searchBar.endEditing(true)
//
////        searchBar.becomeFirstResponder()
//        return true
//    }
//
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        tblView.isHidden = false
//        return true
//
//    }
//
//    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        self.view.endEditing(true)
//        self.searchBar.endEditing(true)
//        searchBar.resignFirstResponder()
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
////        tblView.isHidden = true
////        searchActive = true
////        searchBar.text = ""
////        searchBar.placeholder = "Search"
////        searchBar.resignFirstResponder()
////        self.tblView.reloadData()
//
////        self.searchBar.endEditing(false)
////        searchBar.becomeFirstResponder()
//
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//    }
}

