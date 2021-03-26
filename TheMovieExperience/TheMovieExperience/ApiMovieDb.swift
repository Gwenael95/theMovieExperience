//
//  ApiMovieDb.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import Foundation
import UIKit

class ApiMovieDb {
    let properties = Properties.parseConfig()

    struct Movie : Codable{
        let original_title: String
    }
    
    let endpoint = "https://api.themoviedb.org/3/movie/550?api_key=b08dd80fbf5aa44ca65a80f96b6452e2"
    
    
    func getSearchUrl(query : String) -> String{
       return "https://api.themoviedb.org/3/search/movie?api_key=" + properties.API_KEY + "&query=" + query + "&page=1"
    }
    /**
        because of API, page =1 return 20 result. we don't want to display more than this
        to avoid problem when loading
     */
    func searchMovie(query : String) -> [String]{
        let urlString = self.getSearchUrl(query: query)
        var movies = [String]()
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
                                movies.append(item["original_title"]! as! String)
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async  {
                print(movies)
            }
        }
        task.resume()
        return movies
    }
    
    
    // @ todo : fix error when space or special char
    func getJson(query:String, completion: @escaping ([String]) -> Void) {
        
        let urlString = self.getSearchUrl(query: query)
        //let urlString = self.getSearchUrl(query: query) .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    
        var movies = [String]()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlFind = URL(string: urlString)
        let request = URLRequest(url: urlFind!)

        session.dataTask(with:request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let items = data["results"] as? [[String: AnyObject]] {
                            for item in items {
                                movies.append(item["original_title"]! as! String)
                            }
                        }
                    }
                }
                completion(movies)

            } catch let error as NSError {
                completion([])
            }
        }).resume()
    }


    
    
    
    
    
    func getImage(){
        // url =
    }
    
    func getYoutubeLink(){
        
    }
}
