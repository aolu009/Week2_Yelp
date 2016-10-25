//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate {
    
    @IBOutlet weak var businessTable: UITableView!
    var businesses: [Business]?
    var searchBar: UISearchBar!
    var searchTerm : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessTable.estimatedRowHeight = 400
        businessTable.rowHeight = UITableViewAutomaticDimension
        // Initialize the UISearchBar
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        
        
        Business.searchWithTerm(term: "restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    print(business.categories)
                    print(business.distance)
                    
                }
            }
            self.businessTable.reloadData()
            }
        )
        print("Array size:",self.businesses?.count)
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowNumber = self.businesses?.count{
            return rowNumber
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessDetailCell") as! BusinessDetailTableViewCell
        // Encapsulate elegantly in BusinessDetailTableViewCell.swift
        cell.business = businesses?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNVC = segue.destination as! UINavigationController
        let destinationVC = destinationNVC.topViewController as! FilterViewController
        destinationVC.delegate = self
    }
    
    //bestMatched = 0, distance = 1, highestRated = 2
    func filterViewController(filterViewController: FilterViewController, didUpdateFilter filter: [String : AnyObject]) {
        let categories = filter["categories"] as? [String]
        print("Working")
        Business.searchWithTerm(term: "restaurant", sort: YelpSortMode(rawValue: 1), categories: categories, deals: nil, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            print("Working")
            self.businessTable.reloadData()
            }
        )
    }
}


// SearchBar methods not yet implemented correctly
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            self.searchTerm = searchText
        }
        else{
            self.searchTerm = "restaurant"
        }
        
        searchBar.resignFirstResponder()
        print("DO search")
        Business.searchWithTerm(term: self.searchTerm!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    print(business.categories)
                    print(business.distance)
                    
                }
            }
            self.businessTable.reloadData()
            }
        )
    }
}


