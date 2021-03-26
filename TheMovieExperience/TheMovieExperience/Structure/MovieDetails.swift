//
//  MovieDetails.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 26/03/2021.
//

import Foundation

struct MovieDetails : Codable{
    let original_title: String
    let id : Int
    let release_date: String
    let poster_path : String
    let genres: [String]
    let vote_average : Float
    let overview : String
}

extension MovieDetails{

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
