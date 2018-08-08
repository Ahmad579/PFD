//
//  PFDOrderDetailVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 21/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDOrderDetailVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var menuList : [RestaurantMenu]?
    var orderDetail : OrderListObject?
    var priceOfItems = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "PFDOrderItemCell", bundle: nil), forCellReuseIdentifier: "PFDOrderItemCell")
        tblView.register(UINib(nibName: "PFDTotalCost", bundle: nil), forCellReuseIdentifier: "PFDTotalCost")
        tblView.register(UINib(nibName: "PFDOrderCell", bundle: nil), forCellReuseIdentifier: "PFDOrderCell")
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
        tblView.tableFooterView = UIView(frame: .zero)
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension PFDOrderDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return (self.orderDetail?.items?.count)!
        } else {
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PFDOrderCell", for: indexPath) as? PFDOrderCell
            cell?.lblRestaurentName.text = orderDetail?.restaurent?.name
            let orderNumber = orderDetail?.id
            cell?.lblOrderNo.text = "Order No.\(orderNumber!)"
            cell?.lblDate.text = orderDetail?.order_date
            return cell!
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PFDOrderItemCell", for: indexPath) as? PFDOrderItemCell
            let itemPrice = self.orderDetail?.items![indexPath.row].price
            cell?.lblNumberOfItem.text = "\(indexPath.row) )"
            cell?.lblItemName.text = self.orderDetail?.items![indexPath.row].menuItem?.item_name
            cell?.lblPriceOfItem.text = "PKR \(itemPrice!)"
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PFDTotalCost", for: indexPath) as? PFDTotalCost
            let totalPayment = self.orderDetail?.total_payment
            cell?.lblSubTotal.text = "PKR \(totalPayment!)"
            
            
            
            return cell!
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDRestaurantDetailVC") as? PFDRestaurantDetailVC
        //            //        vc?.requestObj = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row]
        //            vc?.restaurentInfo = self.responseObj?.listOfRestaurant![indexPath.row]
        //
        //            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 117.0
        } else if indexPath.section == 1 {
            return 58.0
            
        } else {
            return 107.0
            
        }
    }
    
    
    
}

