//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Appwox on 4.04.2021.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    var restaurant:Restaurant?
    
    @IBOutlet var restaurantImageView:UIImageView!
    @IBOutlet var restaurantName:UILabel!
    @IBOutlet var restaurantType:UILabel!
    @IBOutlet var restaurantLocation:UILabel!
    
    @IBOutlet var restaurantInfoView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantInfoView.layer.cornerRadius = CGFloat(10)
        
        restaurantImageView.image = UIImage(named: restaurant?.image ?? "")
        restaurantName.text = restaurant?.name
        restaurantLocation.text = restaurant?.location
        restaurantType.text = restaurant?.type
        
        // Disable large title
        navigationItem.largeTitleDisplayMode = .never
    }
}
