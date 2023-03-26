//
//  RestaurantDetailTwoColumnCell.swift
//  FoodPin
//
//  Created by Appwox on 16.04.2021.
//

import UIKit

class RestaurantDetailTwoColumnCell: UITableViewCell {
    @IBOutlet var column1TitleLabel: UILabel! {
        didSet {
            column1TitleLabel.text = column1TitleLabel.text?.uppercased()
            column1TitleLabel.numberOfLines = 0
        }
    }
    @IBOutlet var column1TextLabel: UILabel! {
        didSet {
            column1TextLabel.numberOfLines = 0
        }
    }
    @IBOutlet var column2TitleLabel: UILabel! {
        didSet {
            column1TitleLabel.text = column1TitleLabel.text?.uppercased()
            column1TitleLabel.numberOfLines = 0
        }
    }
    @IBOutlet var column2TextLabel: UILabel! {
        didSet {
            column1TextLabel.numberOfLines = 0
        }
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
