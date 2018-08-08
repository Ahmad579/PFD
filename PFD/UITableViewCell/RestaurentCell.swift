//
//  RestaurentCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 05/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class RestaurentCell: UITableViewCell {
    @IBOutlet weak var collectionViewCell: UICollectionView!
    var featureItem    : UserResponse?
    @IBOutlet weak var lblNumberOfItem: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension RestaurentCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.featureItem?.dealList?.count)!

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealCollectionCell", for: indexPath) as! DealCollectionCell
        let imageName = self.featureItem?.dealList?[indexPath.row].image
        
        let restaurentImage = imageName?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:restaurentImage! , imageView: (cell.imgOfDeal!), placeHolder: "image_placeholder")
        cell.lblDealType.text = self.featureItem?.dealList?[indexPath.row].deal_type
        cell.lblNameOfDeal.text = self.featureItem?.dealList?[indexPath.row].deal_name
        cell.lblDescriptionOfDeal.text = self.featureItem?.dealList?[indexPath.row].deal_description
        cell.lblRestaurentName.text = self.featureItem?.dealList?[indexPath.row].restaurent?.name
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 250.0)
    }
    
    
}

