//
//  ApiMovieDb.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import Foundation
import UIKit

struct Movie : Codable{
    let original_title: String
    let id : Int
}

extension Movie{ // voir comment structurer les donné de l'artiste via un json recu pour un artiste; new Artist; .name = json["name"] par ex ?)

    init?(json: [String: AnyObject]) {
        guard let original_title = json["original_title"] as? String, let id = json["id"] as? Int
        else {
            return nil
        }

        self.original_title = original_title
        self.id = id
    }

}

class ApiMovieDb {
    let properties = Properties.parseConfig()

    let endpoint = "https://api.themoviedb.org/3/movie/550?api_key=b08dd80fbf5aa44ca65a80f96b6452e2"
    
    
    func getSearchUrl(query : String) -> String{
       return "https://api.themoviedb.org/3/search/movie?api_key=" + properties.API_KEY + "&query=" + query + "&page=1"
    }
    /**
        because of API, page =1 return 20 result. we don't want to display more than this
        to avoid problem when loading
     */
    // @ todo : fix error when space or special char
    func searchMovies(query:String, completion: @escaping ([Movie]) -> Void) {
        
        let urlString = self.getSearchUrl(query: query)
        //let urlString = self.getSearchUrl(query: query) .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    
        var movies = [Movie]()
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
                                if let movie = Movie(json:item){
                                    movies.append(movie)
                                }
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
