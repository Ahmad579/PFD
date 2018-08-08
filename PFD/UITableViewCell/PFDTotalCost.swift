//
//  PFDTotalCost.swift
//  PFD
//
//  Created by Ahmed Durrani on 21/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDTotalCost: UITableViewCell {

    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
