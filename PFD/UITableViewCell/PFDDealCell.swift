//
//  PFDDealCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 20/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDDealCell: UITableViewCell {

    @IBOutlet weak var imgOFRestaurent: UIImageView!
    
    @IBOutlet weak var lblRestaurnetName: UILabel!
    
    @IBOutlet weak var lblDealType: UILabel!
    
    @IBOutlet weak var lblDealName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblPriceOfDeal: UILabel!
    
    @IBOutlet weak var lblWeeklyOrMonthly: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
