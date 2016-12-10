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
    var ganre:[String] = []

    @IBAction func editBT(_ sender: UIBarButtonItem) {
        self.isEditing = !self.isEditing
        print("editmode: \(self.isEditing)")
        if self.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
        self.saveList()
    }
    @IBAction func addFavorite(_ sender: UIBarButtonItem) {
        let message = UIAlertController(title: "New favorite performer", message: "", preferredStyle: .alert)
        message.addTextField(configurationHandler: { (textField: UITextField) -> Void in
            textField.placeholder = "Performer name"
        })
        message.addTextField(configurationHandler: { (textField: UITextField) -> Void in
            textField.placeholder = "Genre"
        })
        message.addAction(UIAlertAction(title: "Add", style: .default, handler: {(action)  in
            if let textMessage = message.textFields {
                let name = textMessage[0].text
                let ganre = textMessage[1].text
                self.favorites.append(name!)
                self.ganre.append(ganre!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            self.saveList()
        }))
        message.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(message, animated: true, completion: nil)
    }
    
    
    func saveList() {
        let saved = UserDefaults.standard
        saved.set(ganre, forKey: "Gaanre")
        saved.set(favorites, forKey: "favorites")
        saved.synchronize()
        print(favorites)
        print("data laoded")
    }
    
    override func viewDidLoad() {
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath)
        if let label = cell.textLabel {
            label.text = self.favorites[indexPath.row]

        }
        // Configure the cell..

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}