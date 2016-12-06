//
//  TableController.swift
//  Lyx
//
//  Created by Miroslav Ivanov on 03/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import UIKit
import Events

class TableController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchQuery: String) {
        print("Search: \(searchQuery)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text{
            print("Search button pressed: \(search)")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            try? Eventim.sharedInstance.search(withText: search, { () in
                print("search complete")
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                }
            })
            
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
        return Eventim.sharedInstance.count
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites", for: indexPath)

        if let lable = cell.textLabel, let detail = cell.detailTextLabel {
            lable.text = Eventim.sharedInstance.getEvent(forIndex: indexPath.row).title
            detail.text = Eventim.sharedInstance.getEvent(forIndex: indexPath.row).country
        }
        // Configure the cell...

        return cell
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(segue.identifier!)
        if segue.identifier == "favoriteResult" {
            print("segue: \(segue.identifier)")
            if let IndexPath = self.tableView.indexPathForSelectedRow {
                print("found row \(IndexPath.row)")
                if let navigationController = segue.destination as? UINavigationController {
                    if let eventsController = navigationController.topViewController as? EventsController {
                        print("found Table Controller")
                        eventsController.event = Eventim.sharedInstance.getEvent(forIndex: IndexPath.row)
                       // eventsController.event = Eventim.sharedInstance.getEvent(forIndex: IndexPath.row).region
                        
                       // eventsController.event = try? Eventim.sharedInstance.getFavorites(atIndex: IndexPath.row).city
                    }
                }
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
