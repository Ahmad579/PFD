//
//  PFRestaurantCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import Cosmos
class PFRestaurantCell: UITableViewCell {
    
    @IBOutlet var imgOfrestaurant: UIImageView!
    @IBOutlet var lblBrowse: UILabel!

    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet var lblRetaurantName: UILabel!
    @IBOutlet var lblDeliveryFee: UILabel!
    
    @IBOutlet var lblOpensTill: UILabel!
    @IBOutlet var lblTiming: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
