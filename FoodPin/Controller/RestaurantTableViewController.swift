//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Appwox on 21.03.2021.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    // 👇 Table data.
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type:"French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]
    
    lazy var dataSource = configureDataSource()

    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 👇 We first assign our custom dataSource to the table view's data source.
        tableView.dataSource = dataSource
        // 👇 Remove default seperator style from table view
        tableView.separatorStyle = .none
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        // 👇 Call appendItems to add all items in the restaurants array to the .all section.
        snapshot.appendItems(restaurants, toSection: .all)
        // 👇 Populate the data.
        dataSource.apply(snapshot, animatingDifferences: false)
        // 👇 Adjust the cell width automatically
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - UITableView Diffable Data Source
    // 🚩 The symbol (->) means return. The type that follows is the type of returned object.
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {

        let cellIdentifier = "datacell"
        
        // 🚩 When initializing the object, it is required to provide the instance of table view that the data source is connected, plus the cell provider. 👇
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: { // 👇 where you set up each cell of the table view.
                tableView, indexPath, _ in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                cell.nameLabel?.text = self.restaurants[indexPath.row].name
                cell.thumbnailImageView?.image = UIImage(named: self.restaurants[indexPath.row].image)
                cell.typeLabel?.text = self.restaurants[indexPath.row].type
                cell.locationLabel?.text = self.restaurants[indexPath.row].location
                cell.favoriteHeart.isHidden = self.restaurants[indexPath.row].isFavorite ? false : true
                return cell
            }
        )

        return dataSource
    }
    
    // MARK: -UITableViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
        let currentCellNameLabel = currentCell.nameLabel.text!
        
        // Create an option menu as an action sheet.
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do with \(currentCellNameLabel)?", preferredStyle: .actionSheet)
        
        // 🚩👇 it will store the popover presentation controller when the app is run on "iPad".
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        // MARK: Add actions to the menu.
        
        // Add Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add "Reserve a table" action.
        let reserveActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not Available Yet", message: "Sorry this feature is not available yet!", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        let reserveAction = UIAlertAction(title: "Reserve a table at \(currentCellNameLabel)", style: .default, handler: reserveActionHandler)
        
        optionMenu.addAction(reserveAction)
        
        // Add favorite action.
        let favoriteActionTitle = self.restaurants[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite"
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in

            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell

            cell.favoriteHeart.isHidden = self.restaurants[indexPath.row].isFavorite

            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            
        })
        
        optionMenu.addAction(favoriteAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselct the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    // MARK: Swipe left to right
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get selected restaurant.
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        // Delete action.
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, comletionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // Remove from restaurants array.
            self.restaurants.remove(at: indexPath.row)
            
            // Call completion handler to dismiss the action button
            comletionHandler(true)
        }
        // Share action.
        let shareAction = UIContextualAction(style: .normal, title: "Share") {
            (action, sourceView, completionHandler) in
            
            let activityController: UIActivityViewController
            
            let defaultText = "Just checking in at " + restaurant.name
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // Change the button's color
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
    
        // Configure both actions as swipe action.
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    // MARK: Swipe right to left
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Add to favorite action.
        let favoriteAction = UIContextualAction(style: .normal, title: self.restaurants[indexPath.row].isFavorite ? "Remove from favorites" : "Mark as favorite") {
            (action, sourceView, completionHandler) in
           
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            cell.favoriteHeart.isHidden = self.restaurants[indexPath.row].isFavorite
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Configure swipe action
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: self.restaurants[indexPath.row].isFavorite ? "heart.slash.fill" : "heart.fill")
        
        
        // Configure actions as swipe action.
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
}