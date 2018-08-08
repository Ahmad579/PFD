//
//  PFDCartVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDCartVC: UIViewController {
    var selectItemMenu : [RestaurantMenu]?
    var cartMenu       : MOCart?
    var menuItemsList: NSMutableArray!
    var restaurentInfo : AllRestaurantList?

    @IBOutlet var tblView: UITableView!
    var priceOfItems = 0
    var numberOfItem = 1
    var isValueAddOrSub : Bool?
    var totalPriceOfItem : String?
    var subTotalPrice :String?
    @IBOutlet weak var lblPriceOfItem: UILabel!

    var isValueAdd  : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItemsList = NSMutableArray()

        for (_ , menuItem) in (self.selectItemMenu?.enumerated())!{
            cartMenu = MOCart(id: menuItem.id, menu_category_id: menuItem.menu_category_id, menu_item_id: menuItem.menu_item_id, item_name: menuItem.item_name, descriptionOfMenu: menuItem.description, available: menuItem.available, price: menuItem.price, order_id: menuItem.order_id, quantity: menuItem.quantity, comment: "Comment here")
                priceOfItems = priceOfItems + Int(menuItem.price!)!

                self.menuItemsList.add(self.cartMenu!)

        }
        isValueAddOrSub = true
        isValueAdd = true
        tblView.tableFooterView = UIView(frame: .zero)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCheckOut_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PFDCheckOutVC") as? PFDCheckOutVC
        vc?.selectItemMenu = selectItemMenu
        vc?.cartMenu = cartMenu
        vc?.menuItemsList = menuItemsList
        vc?.restaurentInfo = restaurentInfo
        vc?.subTotalPrice = subTotalPrice
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   

}

extension PFDCartVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (menuItemsList?.count)!

        }else if section == 1  {
            return 1
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell: PFDCartCell? = tableView.dequeueReusableCell(withIdentifier: "cartItem") as! PFDCartCell?
            let menu: MOCart? = (self.menuItemsList[indexPath.row] as? MOCart)
            if cell == nil {
                cell = PFDCartCell(style: .default, reuseIdentifier: "cartItem")
            }
            let priceOfItem = menu?.price
            let itemQuantity = menu?.available

//            cell?.lblItemName.text = self.selectItemMenu![indexPath.row].item_name
            cell?.lblItemName.text = menu?.item_name
            cell?.lblPRice.text = "PKR\(priceOfItem!)"
            cell?.lblItem.text = "\(itemQuantity!) Item"
            
//            cell?.lblItemName.text = menu?.item_name

//            cell?.lblPRice.text = "PKR\(self.selectItemMenu![indexPath.row].price!)"
            WAShareHelper.setBorderAndCornerRadius(layer: (cell?.viewOfIncreaseDecrease.layer)!, width: 1.0, radius: 0.0, color: UIColor(red: 252/255.0, green: 101/255.0, blue: 103/255.0, alpha: 1.0))
          
            cell?.lblRowNum.text = "\(indexPath.row) )"
            cell?.delegate = self
            cell?.index = indexPath
            return cell!
        
        } else if indexPath.section == 1 {
            var cell: PFDCartCell? = tableView.dequeueReusableCell(withIdentifier: "coupon") as! PFDCartCell?
            if cell == nil {
                cell = PFDCartCell(style: .default, reuseIdentifier: "coupon")
            }
            
            return cell!
            
        } else {
            var cell: PFDCartCell? = tableView.dequeueReusableCell(withIdentifier: "subTotal") as! PFDCartCell?
            if cell == nil {
                cell = PFDCartCell(style: .default, reuseIdentifier: "subTotal")
            }
            
            cell?.lblSubtotal.text = "PKR \(priceOfItems)"
            lblPriceOfItem.text = "PKR \(priceOfItems)"
            self.subTotalPrice = cell?.lblSubtotal.text?.replacingOccurrences(of: "PKR ", with: "")

            
            return cell!
        }
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 109.0
        } else if indexPath.section == 1 {
            return 58.0
        } else {
            return 113.0
        }
    }
    
}
extension PFDCartVC : AddOrSubToCart {
   
    func addToCart(checkCell : PFDCartCell , indexPath : IndexPath) {
        isValueAddOrSub = true
        isValueAdd = false

        let selectPrice = checkCell.lblPRice.text?.replacingOccurrences(of: "PKR", with: "")
        
        let item = checkCell.lblItem.text?.replacingOccurrences(of: " Item", with: "")
        let menu: MOCart? = (self.menuItemsList[indexPath.row] as? MOCart)
        totalPriceOfItem = self.selectItemMenu![indexPath.row].price!
        priceOfItems = Int(subTotalPrice!)! + Int(totalPriceOfItem!)!
        let price : Int = Int(selectPrice!)! + Int(totalPriceOfItem!)!
        let itemSelect : Int = Int(item!)! + 1

        self.menuItemsList[indexPath.row] = MOCart(id: menu?.id, menu_category_id: menu?.menu_category_id, menu_item_id: menu?.menu_item_id, item_name: menu?.item_name, descriptionOfMenu: menu?.description, available: "\(itemSelect)", price: "\(price)", order_id: menu?.order_id, quantity: menu?.quantity,comment: "Comment here")
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        let indexPath1 = IndexPath(item: 0, section: 2)

        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.reloadRows(at: [indexPath1], with: .none)


    }
    
    func subToCart(checkCell : PFDCartCell , indexPath : IndexPath) {
        isValueAddOrSub = false
        isValueAdd = false

        let selectPrice = checkCell.lblPRice.text?.replacingOccurrences(of: "PKR", with: "")
        let item = checkCell.lblItem.text?.replacingOccurrences(of: " Item", with: "")
        let menu: MOCart? = (self.menuItemsList[indexPath.row] as? MOCart)
        totalPriceOfItem = self.selectItemMenu![indexPath.row].price!
        let price : Int = Int(selectPrice!)! - Int(totalPriceOfItem!)!
        let itemSelect : Int = Int(item!)! - 1
        priceOfItems = Int(subTotalPrice!)! - Int(totalPriceOfItem!)!

        //        cell?.lblItem.text = "\(menu?.available) Item"
        
        self.menuItemsList[indexPath.row] = MOCart(id: menu?.id, menu_category_id: menu?.menu_category_id, menu_item_id: menu?.menu_item_id, item_name: menu?.item_name, descriptionOfMenu: menu?.description, available: "\(itemSelect)", price: "\(price)", order_id: menu?.order_id, quantity: menu?.quantity , comment: "Comment here")
        let indexPath = IndexPath(item: indexPath.row, section: 0)
        let indexPath1 = IndexPath(item: 0, section: 2)
        
        tblView.reloadRows(at: [indexPath], with: .none)
        tblView.reloadRows(at: [indexPath1], with: .none)


    }

    
}

//extension UITableView {
//    func refreshTable(){
//        let indexPathForSection = NSIndexSet(index: 0)
//        self.reloadSections(indexPathForSection, withRowAnimation: UITableViewRowAnimation.Middle)
//    }
//}

