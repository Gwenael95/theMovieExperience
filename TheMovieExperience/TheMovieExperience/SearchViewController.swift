import UIKit

class SearchViewController: UIViewController {
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
}
