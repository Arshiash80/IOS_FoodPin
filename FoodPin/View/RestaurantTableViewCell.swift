//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Appwox on 25.03.2021.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView:UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 20.0
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet var favoriteHeart:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
