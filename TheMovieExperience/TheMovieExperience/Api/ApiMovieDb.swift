//
//  ApiMovieDb.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 25/03/2021.
//

import Foundation
import UIKit

extension CharacterSet {

    /// Returns the character set for characters allowed in the individual parameters within a query URL component.
    ///
    /// The query component of a URL is the component immediately following a question mark (?).
    /// For example, in the URL `http://www.example.com/index.php?key1=value1#jumpLink`, the query
    /// component is `key1=value1`. The individual parameters of that query would be the key `key1`
    /// and its associated value `value1`.
    ///
    /// According to RFC 3986, the set of unreserved characters includes
    ///
    /// `ALPHA / DIGIT / "-" / "." / "_" / "~"`
    ///
    /// In section 3.4 of the RFC, it further recommends adding `/` and `?` to the list of unescaped characters
    /// for the sake of compatibility with some erroneous implementations, so this routine also allows those
    /// to pass unescaped.


    static func urlQueryCustomValueAllowed() -> CharacterSet {
        return CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~:/?&=")
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
    
    func getImageFromMovieDbApi(path:String) -> String{
        return "https://image.tmdb.org/t/p/w500" + path
    }
    func getAllMovieImage(id:Int, language:String) -> String{
        return "https://api.themoviedb.org/3/movie/\(id)/images?api_key=" + properties.API_KEY + "&language=" + language
    }
    
    func getAllMovieVideo(id:Int, language:String?) -> String{
        return "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=" + properties.API_KEY + ((language ?? "").isEmpty ? "" : "&language=" + language!)
    }
    
    func getYoutubeImageLink(key:String) -> String{
        return "https://i.ytimg.com/vi/" + key + "/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&amp;rs=AOn4CLCw1BAmwgAuP1vSuZ4ucr35TYfmOA"
    }
    func getYoutubeVideoLink(key:String) -> String{
        return "https://www.youtube.com/watch?v=" + key
    }
    
    
    /**
        because of API, page =1 return 20 result. we don't want to display more than this
        to avoid problem when loading
     */
    // @ todo : fix error when space or special char
    func searchMoviesByName(query:String, completion: @escaping ([Movie]) -> Void) {
        
        //let urlString = self.getSearchUrl(query: query)
        let urlString = self.getSearchUrl(query: query) .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryCustomValueAllowed())
    
        var movies = [Movie]()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlFind = URL(string: urlString!)
        let request = URLRequest(url: urlFind!)

        session.dataTask(with:request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

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

    func searchMovieVideos(id:Int, completion: @escaping ([MovieVideo]) -> Void) {
        let urlString = self.getAllMovieVideo(id: id, language: nil)
        
        var movies = [MovieVideo]()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlFind = URL(string: urlString)
        let request = URLRequest(url: urlFind!)

        session.dataTask(with:request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                if let data = json as? [String: AnyObject] {
                    if let items = data["results"] as? [[String: AnyObject]] {
                        for item in items {
                            if let movie = MovieVideo(json:item){
                                movies.append(movie)
                            }
                        }
                    }
                }
            }
            completion(movies)

        }).resume()
    }
    
}
