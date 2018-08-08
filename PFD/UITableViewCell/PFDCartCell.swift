//
//  PFDCartCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

protocol AddOrSubToCart {
    func addToCart( checkCell : PFDCartCell , indexPath : IndexPath)
    func subToCart(checkCell : PFDCartCell , indexPath : IndexPath)

}

class PFDCartCell: UITableViewCell {

    @IBOutlet weak var lblRowNum: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblPRice: UILabel!
    
    
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var viewOfIncreaseDecrease: UIView!
    var delegate: AddOrSubToCart?
    var index: IndexPath?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnAddToCart(_ sender: UIButton) {
        self.delegate?.addToCart(checkCell: self, indexPath: index!)
    }
    
    @IBAction func btnSubToCart(_ sender: UIButton) {
        self.delegate?.subToCart(checkCell: self, indexPath: index!)
    }
}
