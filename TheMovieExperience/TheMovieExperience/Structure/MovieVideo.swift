//
//  MovieVideo.swift
//  TheMovieExperience
//
//  Created by GwenaelMarchetti on 26/03/2021.
//

import Foundation

struct MovieVideo : Codable{
    let key: String
    let site : String
    let id  : String
    let name : String
    let type : String
}

extension MovieVideo{
   init?(json: [String: AnyObject]) {
       guard let key = json["key"] as? String, let site = json["site"] as? String,  let id = json["id"] as? String, let name = json["name"] as? String,  let type = json["type"] as? String
       else {
           return nil
       }

        self.key = key
        self.site = site
        self.id = id
        self.name = name
        self.type = type
   }

}
