//
//  ApiMovieDb.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import Foundation
import UIKit

/**
 contains only usefull data to display for movie search
 */
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


struct MovieDetails : Codable{
    let original_title: String
    let id : Int
    let release_date: String
    let poster_path : String
    let genres: [String]
    let vote_average : Float
    let overview : String
}

extension MovieDetails{ // voir comment structurer les donné de l'artiste via un json recu pour un artiste; new Artist; .name = json["name"] par ex ?)

    init?(json: [String: AnyObject]) {
        
        guard let original_title = json["original_title"] as? String,
              let id = json["id"] as? Int,
              let release_date = json["release_date"] as? String,
              let poster_path = json["poster_path"] as? String,
              let genres = json["genres"] as? [[String: AnyObject]],
              let vote_average = json["vote_average"] as? NSNumber,
              let overview = json["overview"] as? String
        else{
            return nil
        }

        let voteFloat = vote_average.floatValue 

        var genresStrArr = [String]()
        genresStrArr.append("horror")
        
        for item in genres {
            genresStrArr.append(item["name"] as! String)
        }
        
        
        
        self.original_title = original_title
        self.id = id
        self.release_date = release_date
        self.poster_path = poster_path
        self.genres = genresStrArr
        self.vote_average = voteFloat
        self.overview = overview
    }

}

class ApiMovieDb {
    let properties = Properties.parseConfig()

    
    func getSearchUrl(query : String) -> String{
        return properties.API_URL + "search/movie?api_key=" + properties.API_KEY + "&query=" + query + "&page=1"
    }
    
    func getMovieDetailsUrl(id : Int) -> String{
        return properties.API_URL + "movie/\(id)?api_key=" + properties.API_KEY
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


    
    
    func searchMovieDetails(id:Int, completion: @escaping (MovieDetails) -> Void) {
        let urlString = self.getMovieDetailsUrl(id: id)
        
        var movieDetails = MovieDetails(original_title: "", id: 1, release_date: "", poster_path: "", genres: [], vote_average: 0, overview: "")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlFind = URL(string: urlString)
        let request = URLRequest(url: urlFind!)
        print("try for id = \(id) , url = " + urlString)
        session.dataTask(with:request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let movie = MovieDetails(json:data){
                            movieDetails = movie
                        }
                        else{
                            print("fail , json issn't goof for id = \(id) , url = " + urlString)
                            print(data)
                        }
                    }
                }
                completion(movieDetails)

        }).resume()
    }

    
    
    func getImage(path:String) -> String{
        return "https://image.tmdb.org/t/p/w500" + path
    }
    
    func getYoutubeLink(key:String) -> String{
        return "https://i.ytimg.com/vi/" + key + "/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLCw1BAmwgAuP1vSuZ4ucr35TYfmOA"
    }
}
