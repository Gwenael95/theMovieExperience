//
//  SearchViewController.swift
//  TheMovieExperience
//
//  Created by Hugo Monnerie on 24/03/2021.
//

import UIKit
import Foundation

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]


    struct Movie : Codable{
        let original_title: String
    }
        
    let endpoint = "https://api.themoviedb.org/3/movie/550?api_key=b08dd80fbf5aa44ca65a80f96b6452e2"
    let apiMovie = ApiMovieDb()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.data.removeAll()
        
        /*
         at least it works, but try another way
        let urlString = apiMovie.getSearchUrl(query: searchBar.text!);
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
       
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let items = data["results"] as? [[String: AnyObject]] {
                            for item in items {
                                self.data.append(item["original_title"]! as! String)
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async  {
                self.tableView.reloadData()
            }
        }
        task.resume()
        */
        
        
        //@todo :  launch api request with searchbar content
        //let movies = apiMovie.searchMovie(query: searchBar.text!)
        //print(movies)
        //self.data = movies
        let _: () = apiMovie.getJson(query:searchBar.text!) { result in
            print(result)
           
            DispatchQueue.main.async {
                self.data = result
                self.tableView.reloadData()
            }

        }
        
        
        //tableView.reloadData()
 
    }
    
    func apiTest() {
        if let url = URL(string: endpoint) {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                     let res = try JSONDecoder().decode(Movie.self, from: data)
                    print(res.original_title)
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }
}
