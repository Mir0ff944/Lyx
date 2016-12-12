//
//  FavoriteController.swift
//  Lyx
//
//  Created by Miroslav Ivanov on 10/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import UIKit
import Events


class FavoriteController: UITableViewController {
    

    var favorites:[String] = []

    /// Button outlet, connected to the button on the navigation bar that treiggers an action upon pressing on the button
    ///
    /// - Parameter sender: Bar button
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
        let message = UIAlertController(title: "New favorite performer", message: "", preferredStyle: .alert)
        message.addTextField(configurationHandler: { (textField: UITextField) -> Void in
            textField.placeholder = "Performer name"
            textField.accessibilityIdentifier = "nameField"
        })

        message.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action)  in
            if let textMessage = message.textFields {
                let name = textMessage[0].text
                self.favorites.append(name!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            self.saveList()
        }))
        message.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(message, animated: true, completion: nil)
    }
    
    
    /// Method that saves the data stored inside the favorites list into the User Defaults
    func saveList() {
        let saved = UserDefaults.standard
        saved.set(favorites, forKey: "favorites")
        saved.synchronize()
        print(favorites)
        print("data laoded")
    }
    
    /// Displays data stored inside the User Defaults into the table view
    override func viewDidLoad() {
        self.navigationItem.title = NSLocalizedString("Favorites", comment: "Title of the navigation bar")
        
        super.viewDidLoad()
        let savedItems = UserDefaults.standard
        if let loadedItems:[String] = savedItems.object(forKey: "favorites") as! [String]? {
            print("data loaded")
            print(loadedItems)
            self.favorites = loadedItems
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.favorites.count
    }

    
    /// Method that loads data into the table view cell with identifier "favoritecell"
    ///
    /// - Parameters:
    ///   - tableView: table view
    ///   - indexPath: indexPath
    /// - Returns: returns cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath)
        if let label = cell.textLabel {
            label.text = self.favorites[indexPath.row]

        }
        // Configure the cell..

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        self.saveList()
    }


}
