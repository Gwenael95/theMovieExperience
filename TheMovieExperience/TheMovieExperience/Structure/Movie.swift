//
//  Movie.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 26/03/2021.
//

import Foundation

/**
 contains only usefull data to display for movie search
 */
struct Movie : Codable{
    let original_title: String
    let id : Int
}

extension Movie{
    init?(json: [String: AnyObject]) {
        guard let original_title = json["original_title"] as? String,
              let id = json["id"] as? Int
        else {
            return nil
        }

        self.original_title = original_title
        self.id = id
    }

}
