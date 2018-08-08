
//
//  PDFMenuListVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PDFMenuListVC: UIViewController {
   
    var restaurentInfo : AllRestaurantList?

    var menuList : [RestaurantMenu]?
    @IBOutlet var tblView: UITableView!
    var selectedCategory : String?
    @IBOutlet weak var viewOfCart: UIView!
    @IBOutlet weak var lblTitleOfSelectedItem: UILabel!
    @IBOutlet weak var lblItemAdded: UILabel!
    @IBOutlet weak var lblPriceOfItem: UILabel!
    var totalPriceOfItem : String?
    var firstItemPrice : String?
    let ap = UIApplication.shared.delegate as! AppDelegate
    var priceOfItem =  0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.estimatedRowHeight = 82.0
        tblView.rowHeight = UITableViewAutomaticDimension
        lblTitleOfSelectedItem.text = selectedCategory
        
        if (ap.arrayOFSelectedItem?.count)! > 0 {
            for (_ , menuInfo) in (ap.arrayOFSelectedItem?.enumerated())! {
                
                priceOfItem = priceOfItem + Int(menuInfo.price!)!
            }
            
            self.lblPriceOfItem.text = "PKR\(priceOfItem)"
            let itemAdd = ap.arrayOFSelectedItem?.count
            self.lblItemAdded.text = "\(itemAdd!) itesm added"
            self.viewOfCart.isHidden = false
        }
        tblView.tableFooterView = UIView(frame: .zero)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCart_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDCartVC") as? PFDCartVC
        vc?.selectItemMenu = ap.arrayOFSelectedItem
        vc?.restaurentInfo = restaurentInfo
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

    
}

extension PDFMenuListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  menuList?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Menu In this Restaurent."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menuList?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PFDMenuCell? = tableView.dequeueReusableCell(withIdentifier: "PFDMenuCell") as! PFDMenuCell?
        if cell == nil {
            cell = PFDMenuCell(style: .default, reuseIdentifier: "PFDMenuCell")
        }
        let itemSelectedId = self.menuList![indexPath.row].id
        
        cell?.delegate = self
        cell?.index = indexPath
        let itemPrice = self.menuList![indexPath.row].price
        cell?.lblSelectedMenuName.text = self.menuList![indexPath.row].item_name
        cell?.lblSelectItemPrice.text = "PKR \(itemPrice!)"
        cell?.lblDetailOfThisItem.text = self.menuList![indexPath.row].description
        if let index = ap.arrayOFSelectedItem?.index(where: {$0.id == itemSelectedId}) {
            cell?.btnItemSelect.isSelected = true
        } else {
            cell?.btnItemSelect.isSelected = false
        }
        return cell!
    
    }
    
    
    
}

extension PDFMenuListVC  : MenuItemSelected {
    func isItemSelected(checkCell : PFDMenuCell , indexPath : IndexPath) {
        let itemSelectedId = self.menuList![indexPath.row].id

        if checkCell.btnItemSelect.isSelected == true  {
            checkCell.btnItemSelect.isSelected = true
            if ap.arrayOFSelectedItem?.count == 0  {
                ap.arrayOFSelectedItem?.append((self.menuList?[indexPath.row])!)
                
                firstItemPrice = menuList![indexPath.row].price
                let price = Int(firstItemPrice!)
                
                self.lblPriceOfItem.text = "PKR\(price!)"
                let itemAdd = ap.arrayOFSelectedItem?.count
                self.lblItemAdded.text = "\(itemAdd!) itesm added"
                self.viewOfCart.isHidden = false
            } else {
                self.viewOfCart.isHidden = false
                checkCell.btnItemSelect.isSelected = true
                let selectPrice = self.lblPriceOfItem.text?.replacingOccurrences(of: "PKR", with: "")
                
                ap.arrayOFSelectedItem?.append((self.menuList?[indexPath.row])!)

                totalPriceOfItem = menuList![indexPath.row].price
                let price : Int = Int(selectPrice!)! + Int(totalPriceOfItem!)!
                self.lblPriceOfItem.text = "PKR\(price)"
                
                let itemAdd = ap.arrayOFSelectedItem?.count
                self.lblItemAdded.text = "\(itemAdd!) itesm added"

            }
            

        } else {
            checkCell.btnItemSelect.isSelected = false
            
            if let index = ap.arrayOFSelectedItem?.index(where: {$0.id == itemSelectedId}) {
                ap.arrayOFSelectedItem?.remove(at: index)
                let selectPrice = self.lblPriceOfItem.text?.replacingOccurrences(of: "PKR", with: "")
                totalPriceOfItem = menuList![indexPath.row].price
                let price : Int = Int(selectPrice!)! - Int(totalPriceOfItem!)!
                self.lblPriceOfItem.text = "PKR\(price)"


                if ap.arrayOFSelectedItem?.count == 0 {
                    
                    self.viewOfCart.isHidden = true

                    
                } else {
                    self.viewOfCart.isHidden = false
                    let itemAdd = ap.arrayOFSelectedItem?.count
                    self.lblItemAdded.text = "\(itemAdd!) itesm added"

                    
                }
            } else {
                print("Check")
            }

        }
        
    }
}
