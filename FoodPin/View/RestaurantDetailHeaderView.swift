//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Appwox on 15.04.2021.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                // support scalable custom fonts in your app. - UIFontMetrics
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                // support scalable custom fonts in your app. - UIFontMetrics
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }
            
            
    @IBOutlet var heartButton: UIButton!
    


}
