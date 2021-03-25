//
//  SearchViewController.swift
//  TheMovieExperience
//
//  Created by Hugo Monnerie on 24/03/2021.
//

import UIKit
import Foundation


class SearchViewController: UIViewController {

    struct Movie : Codable{
        let original_title: String
    }
    
    let properties = Properties.parseConfig()
    
    let endpoint = "https://api.themoviedb.org/3/movie/550?api_key=b08dd80fbf5aa44ca65a80f96b6452e2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(properties.API_KEY)
        print(properties.API_URL)
        apiTest()
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
