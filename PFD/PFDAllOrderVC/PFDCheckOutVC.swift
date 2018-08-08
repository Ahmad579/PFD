
//
//  PFDCheckOutVC.swift
//  PFD
//
//  Created by Ahmed Durrani on 23/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ObjectMapper
import AlamofireObjectMapper

class PFDCheckOutVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    let ap = UIApplication.shared.delegate as! AppDelegate
    var selectItemMenu : [RestaurantMenu]?
    var cartMenu       : MOCart?
    var menuItemsList: NSMutableArray!
    var restaurentInfo : AllRestaurantList?
    var subTotalPrice :String?
    let size = CGSize(width: 60, height: 60)
    
    
    var menuItemId = [Int]()
    var quantity   = [String]()
    var price      = [String]()
    var comment    = [String]()
    
    var menuItemIdString : String?
    var quantityString : String?
    var priceString : String?
    var commentString : String?

    @IBOutlet weak var imgOfCurrentLocation: UIImageView!
    
//    menu_item_id[]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let email = UserDefaults.standard.string(forKey: "email")
        let name = UserDefaults.standard.string(forKey: "name")
        let phoneNumber = UserDefaults.standard.string(forKey: "phone")
        
        for (index  , menu) in (menuItemsList?.enumerated())! {
            let obj : MOCart = self.menuItemsList![index] as! MOCart
            menuItemId.append(obj.id!)
            quantity.append(obj.available!)
            price.append(obj.price!)
            comment.append("Hi how are you")
        }
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(PFDCheckOutVC.imageTappedForDp(img:)))
        imgOfCurrentLocation.isUserInteractionEnabled = true
        imgOfCurrentLocation.addGestureRecognizer(tapGestureRecognizerforDp)

//        self.menuItemsList[indexPath.row] = MOCart(id: menu?.id, menu_category_id: menu?.menu_category_id, menu_item_id: menu?.menu_item_id, item_name: menu?.item_name, descriptionOfMenu: menu?.description, available: "\(itemSelect)", price: "\(price)", order_id: menu?.order_id, quantity: menu?.quantity , comment: "Comment here")

        
        txtName.text = name
//        txtAddress.text = "Peshawer Rahat Abad"
        txtPhoneNumber.text = phoneNumber!
        
        // Do any additional setup after loading the view.
    }

    @objc func imageTappedForDp(img: AnyObject)
    {
        self.txtAddress.text = DEVICE_ADDRESS
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnDone_Pressed(_ sender: UIButton) {
//        ap.arrayOFSelectedItem = []
        let apiToken = UserDefaults.standard.string(forKey: "api_token")
        let restaurentId = restaurentInfo?.id
        
        menuItemIdString  = self.menuItemId.map({"\($0)"}).joined(separator: "|")
        quantityString        = self.quantity.joined(separator: "|")
        priceString           = self.price.joined(separator: "|")
        commentString         = self.comment.joined(separator: "|")

            
//        let arrayJSON = Mapper().toJSONString(ap.arrayOFSelectedItem!, prettyPrint: true)
//
//        let test = arrayJSON?.filter { !"\n".contains($0) }
////        let fullResult = test?.filter { !"\ ".contains($0) }
//        let fullResults = test?.replacingOccurrences(of: "\"", with: "")
        

//        {"menu_item_id": 10, "quantity": 1, "price": 250, "comment": "Comment here" }
        
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [AnyObject].
        
        
        
        let dateFormatter : DateFormatter = DateFormatter()
//        2018-06-01
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = dateFormatter.string(from: date)

        let checkOutParam = [ "api_token"         : apiToken!,
                              "restaurant_id"     : restaurentId! ,
                              "order_date"        : dateString ,
                              "payment_date"      : dateString ,
                              "sub_total"         : subTotalPrice! ,
                              "coupon_code"       : "sdd" ,
                              "tax"               : "324" ,
                              "address"           : txtAddress.text! ,
                              "menu_item_id"      : menuItemIdString! ,
                              "quantity"          : quantityString! ,
                              "price"             : priceString! ,
                              "comment"           : commentString! ,
                              "delivery_charges"  : "100"

            
            
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:checkOutParam as Dictionary<String, AnyObject> , serviceName: ORDERPLACED, isLoaderShow: true, serviceType: "Order", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            self.stopAnimating()
            if responseObj.response_code == 201 {
                self.ap.arrayOFSelectedItem = []
                UserDefaults.standard.set(responseObj.data?.email , forKey: "email")
                self.showAlertViewWithTitle(title: "PFD", message: responseObj.message!, dismissCompletion: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
                
                
            }else {
                self.showAlertViewWithTitle(title: "PFD", message: responseObj.message!, dismissCompletion: {
//                    self.navigationController?.popViewController(animated: true)
                })
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    
    @IBAction func btnBAck_Pressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
