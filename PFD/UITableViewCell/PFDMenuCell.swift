//
//  PFDMenuCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 12/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

protocol MenuItemSelected {
    func isItemSelected(checkCell : PFDMenuCell , indexPath : IndexPath)
}

class PFDMenuCell: UITableViewCell {
    
    @IBOutlet weak var lblSelectedMenuName: UILabel!
    @IBOutlet weak var lblSelectItemPrice: UILabel!
    
    @IBOutlet weak var lblDetailOfThisItem: UILabel!
    var delegate: MenuItemSelected?
    var index: IndexPath?
    @IBOutlet var btnItemSelect : UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnTimeSelectedOrNot(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
//        btnItemSelect.isSelected = !btnItemSelect.isSelected
        self.delegate?.isItemSelected(checkCell: self, indexPath: index!)
        
        
    }
    

}
