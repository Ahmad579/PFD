//
//  PFDOrderCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 20/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class PFDOrderCell: UITableViewCell {

    @IBOutlet weak var lblRestaurentName: UILabel!
    @IBOutlet weak var viewOfOrder: UIView!
    
    @IBOutlet weak var lblOrderNo: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var imgReceive: UIImageView!
    @IBOutlet weak var imgPrepar: UIImageView!
    @IBOutlet weak var imgDespatch: UIImageView!
    @IBOutlet weak var imgDeliverd: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
