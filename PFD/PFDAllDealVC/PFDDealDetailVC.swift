//
//  PFDDealDetailVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 21/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDDealDetailVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet weak var lblDealName: UILabel!
    @IBOutlet weak var lblRestaurentName: UILabel!
    @IBOutlet weak var lblPriceOfDeal: UILabel!
    @IBOutlet weak var lblNumberOfPerson: UILabel!
    @IBOutlet weak var lblDealPrice: UILabel!
    
    var dealDetail : DealList?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
        tblView.tableFooterView = UIView(frame: .zero)
        let dealPrices = dealDetail?.deal_price
        lblDealName.text = dealDetail?.deal_name
        lblRestaurentName.text = dealDetail?.restaurent?.name
        lblPriceOfDeal.text = "PKR \(dealPrices!)"
        lblDealPrice.text = "PKR \(dealPrices!)"
        
        lblNumberOfPerson.text = "2 Persons"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
extension PFDDealDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.dealDetail?.dealItemList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFDDetailDealCell", for: indexPath) as? PFDDetailDealCell
        let quantity = dealDetail?.dealItemList![indexPath.row].quantity
        let itemName = dealDetail?.dealItemList![indexPath.row].menu?.item_name
        cell?.lblTitleName.text = "\(quantity!) \(itemName!)"
        return cell!
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDRestaurantDetailVC") as? PFDRestaurantDetailVC
    //        //        vc?.requestObj = self.responseObj?.notaryAllList?.selectNotaryList?[indexPath.section].typeObject![indexPath.row]
    //        vc?.restaurentInfo = self.responseObj?.listOfRestaurant![indexPath.row]
    //
    //        self.navigationController?.pushViewController(vc!, animated: true)
    //
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }
    
    
    
}


