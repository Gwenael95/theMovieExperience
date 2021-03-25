//
//  TableViewController.swift
//  TheMovieExperience
//
//  Created by Hugo Monnerie on 25/03/2021.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        
        resultsTableController =
            self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        // This view controller is interested in table view row selections.
        resultsTableController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        
        searchController.searchBar.scopeButtonTitles = [Product.productTypeName(forType: .all),
                                                        Product.productTypeName(forType: .birthdays),
                                                        Product.productTypeName(forType: .weddings),
                                                        Product.productTypeName(forType: .funerals)]

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        /** Search presents a view controller by applying normal view controller presentation semantics.
            This means that the presentation moves up the view controller hierarchy until it finds the root
            view controller or one that defines a presentation context.
        */
        
        /** Specify that this view controller determines how the search controller is presented.
            The search controller should be presented modally and match the physical size of this view controller.
        */
        definesPresentationContext = true
        
        setupDataSource()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
           // Update the filtered array based on the search text.
           let searchResults = products

           // Strip out all the leading and trailing spaces.
           let whitespaceCharacterSet = CharacterSet.whitespaces
           let strippedString =
               searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
           let searchItems = strippedString.components(separatedBy: " ") as [String]

           // Build all the "AND" expressions for each value in searchString.
           let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
               findMatches(searchString: searchString)
           }

           // Match up the fields of the Product object.
           let finalCompoundPredicate =
               NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)

           let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }

           // Apply the filtered results to the search results table.
           if let resultsController = searchController.searchResultsController as? ResultsTableController {
               resultsController.filteredProducts = filteredResults
               resultsController.tableView.reloadData()

               resultsController.resultsLabel.text = resultsController.filteredProducts.isEmpty ?
                   NSLocalizedString("NoItemsFoundTitle", comment: "") :
                   String(format: NSLocalizedString("Items found: %ld", comment: ""),
                          resultsController.filteredProducts.count)
           }
       }

}
