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
    
    func getSession() -> URLSession{
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
    func getRequest(urlString : String) ->URLRequest {
        let urlFind = URL(string: urlString)
        return URLRequest(url: urlFind!)
    }
    
    /**
        because of API, page =1 return 20 result. we don't want to display more than this
        to avoid problem when loading
     */
    // @ todo : fix error when space or special char
    func searchMoviesByName(query:String, completion: @escaping ([Movie]) -> Void) {
        
        let urlString = self.getSearchUrl(query: query) .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryCustomValueAllowed())
    
        var movies = [Movie]()
        
        self.getSession().dataTask(with:self.getRequest(urlString: urlString!), completionHandler: { (data, response, error) in
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
    
    
    func searchMovieDetails(id:Int, completion: @escaping (MovieDetails?) -> Void) {
        let urlString = self.getMovieDetailsUrl(id: id)
        
        self.getSession().dataTask(with:self.getRequest(urlString: urlString), completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }

            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                if let data = json as? [String: AnyObject] {
                    if let movieDetails = MovieDetails(json:data){
                        completion(movieDetails)
                    }
                    else{
                        completion(nil)
                    }
                }
            }
        }).resume()
    }

    
    func searchMovieVideos(id:Int, completion: @escaping ([MovieVideo]) -> Void) {
        let urlString = self.getAllMovieVideo(id: id, language: nil)
        
        var movies = [MovieVideo]()
        
        self.getSession().dataTask(with:self.getRequest(urlString: urlString), completionHandler: { (data, response, error) in
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
