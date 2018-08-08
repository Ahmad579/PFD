//
//  RestaurantDetailCell.swift
//  PFD
//
//  Created by Ahmed Durrani on 11/06/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantDetailCell: UITableViewCell {

    
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet weak var lblRestaurentName: UILabel!
    @IBOutlet weak var distanceFromRestaurent: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    
    @IBOutlet weak var lblMenuItem: UILabel!
    
    @IBOutlet weak var lblFullMenu: UILabel!
    
    @IBOutlet weak var lblItemNumber: UILabel!

    @IBOutlet weak var collectionViewCell: UICollectionView!
    @IBOutlet weak var ratingView: CosmosView!
    var featureItem    : UserResponse?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension RestaurantDetailCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (featureItem?.restaurantDetail?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PFDFeatureItemCell", for: indexPath) as! PFDFeatureItemCell
        let imageUrl = self.featureItem?.restaurantDetail![indexPath.row].restaurentInfo?.image_url
        WAShareHelper.loadImage(urlstring: (imageUrl)! , imageView: cell.imgOfFeature, placeHolder: "image_placeholder")
        cell.lblFeatureName.text = self.featureItem?.restaurantDetail![indexPath.row].menu?.item_name
        let pticeOfFeatureItem = self.featureItem?.restaurantDetail![indexPath.row].menu?.price
        cell.lblFeaturePrice.text = "PKR \(pticeOfFeatureItem!)"

        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/2
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 188.0)
    }
    
    
}

