//
//  PFDRestaurantDetailVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PFDRestaurantDetailVC: UIViewController , NVActivityIndicatorViewable {
    var responseObj: UserResponse?
    var restaurentInfo : AllRestaurantList?
    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var featureItem    : UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllRestaurentDetail()
        // Do any additional setup after loading the view.
    }

    func getAllRestaurentDetail() {
        
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        let restaurentID = restaurentInfo?.id
        let serviceURL =  RESTAURENTDETAIL + "\(restaurentID!)/" + "categories?api_token=\(apiToken!)"
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Restaurent Detail", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            if  self.responseObj?.response_code == 200 {
                self.getAllFeature()
            }
            else {
                
                
                //            self.showAlert(title: "blink", message: (self.categoriesList?.message)!, controller: self)
            }
        }) { (error) in
            
            self.stopAnimating()

            
        }
    }
    
    func getAllFeature() {
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        
        let serviceURL =  ALLFEATURE + "?api_token=\(apiToken!)"
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        WebServiceManager.get(params: nil, serviceName: serviceURL, serviceType: "Restaurant List", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.featureItem = (response as! UserResponse)
            if  self.featureItem?.response_code == 200 {
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
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PFDRestaurantDetailVC: UITableViewDelegate, UITableViewDataSource {


func numberOfSections(in tableView: UITableView) -> Int {
        return 3
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    }else if section == 1  {
        return 1
    } else {
        return (responseObj?.restaurantDetail?.count)!
    }
    
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell: RestaurantDetailCell? = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfo") as! RestaurantDetailCell?
            if cell == nil {
                cell = RestaurantDetailCell(style: .default, reuseIdentifier: "RestaurantInfo")
            }
              cell?.lblRestaurentName.text = restaurentInfo?.name
              let distance  = restaurentInfo?.distance
              cell?.distanceFromRestaurent.text = "\(distance!) km away"
              cell?.lblFoodType.text = "Fast Food"
              cell?.lblDelivery.text = "YES"
              cell?.lblTime.text = "Closed"
              cell?.ratingView.rating = 3.00
  
              return cell!
        }
        else if indexPath.section == 1  {
            var cell: RestaurantDetailCell? = tableView.dequeueReusableCell(withIdentifier: "FeatureItem") as! RestaurantDetailCell?
            if cell == nil {
                cell = RestaurantDetailCell(style: .default, reuseIdentifier: "FeatureItem")
            }
            
            let coutOfItem = self.featureItem?.restaurantDetail?.count
            cell?.lblItemNumber.text = "1/\(coutOfItem!)"

            cell?.featureItem = self.featureItem
            cell?.collectionViewCell.reloadData()
            return cell!
        } else {
            var cell: RestaurantDetailCell? = tableView.dequeueReusableCell(withIdentifier: "MenuItem") as! RestaurantDetailCell?
            if cell == nil {
                cell = RestaurantDetailCell(style: .default, reuseIdentifier: "MenuItem")
            }
            
            if indexPath.row == 0 {
                cell?.lblFullMenu.isHidden = false
            } else {
                cell?.lblFullMenu.isHidden = true

            }
            cell?.lblMenuItem.text = self.responseObj?.restaurantDetail![indexPath.row].category_name
            return cell!
            
            
        }
    
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFMenuListVC") as? PDFMenuListVC
            vc?.menuList = self.responseObj?.restaurantDetail![indexPath.row].menuOfRestaurant
            vc?.selectedCategory = self.responseObj?.restaurantDetail![indexPath.row].category_name
            vc?.restaurentInfo = restaurentInfo
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section ==  0 {
            return 120.0
        } else if indexPath.section == 1 {
            return 189.0
        } else {
            if indexPath.row == 0  {
                return 63.0

            } else {
                return 60.0

            }
        }
    }

}
