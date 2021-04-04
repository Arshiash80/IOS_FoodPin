//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Appwox on 4.04.2021.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource <Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
