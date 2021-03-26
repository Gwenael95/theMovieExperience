//
//  SearchViewController.swift
//  TheMovieExperience
//
//  Created by Hugo Monnerie on 24/03/2021.
//

import UIKit
import Foundation


class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var data  = [Movie]()
        
    let apiMovie = ApiMovieDb()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row].original_title
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click on table view movies")
        if let  vc = UIStoryboard(name:"Main", bundle: nil).instantiateViewController( identifier:"filmDetailsView") as? FilmDetailsViewController
        {
            print("should go on details")
            vc.id = self.data[indexPath.row].id
            self.show(vc, sender: UINavigationController(rootViewController: vc))
        }
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.data.removeAll()
        let _: () = apiMovie.searchMovies(query:searchBar.text!) { result in
            print(result)
           
            DispatchQueue.main.async {
                self.data = result
                self.tableView.reloadData()
            }

        }
    }
    

}
