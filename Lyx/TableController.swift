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
        self.navigationItem.title = NSLocalizedString("Events in Town", comment: "The title of the first table view")
        self.searchBar.placeholder = NSLocalizedString("Search", comment: "Search")
    }
    
    /// A msearch method storing data into an array
    ///
    /// - Parameters:
    ///   - searchBar: search bar
    ///   - searchQuery: search query
    func searchBar(_ searchBar: UISearchBar, textDidChange searchQuery: String) {
        print("Search: \(searchQuery)")
    }
    
    /// Method, executed upon pressing the search button
    ///
    /// - Parameter searchBar: searchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text{
            print("Search button pressed: \(search)")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            try? Eventim.sharedInstance.searchEvent(withText: search, { () in
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

    /// Method that creates number of table cells equal to the events stored inside the Event structure inside the framework
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - section: section
    /// - Returns: returns the number of events
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Eventim.sharedInstance.count
    }
    


    /// Events Table View
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    /// - Returns: loads data into the table view cells and returns it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Events", for: indexPath)

        if let lable = cell.textLabel, let detail = cell.detailTextLabel {
            lable.text = Eventim.sharedInstance.getEvent(forIndex: indexPath.row).title
            detail.text = Eventim.sharedInstance.getEvent(forIndex: indexPath.row).start
        }
        // Configure the cell...

        return cell
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /// Passing data from the table view to the EventsController
    ///
    /// - Parameters:
    ///   - segue: segue identtifier
    ///   - sender: sender
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
                    }
                }
            }
        }

    }


}
