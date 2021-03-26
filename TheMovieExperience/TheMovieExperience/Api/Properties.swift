//
//  Preferences.swift
//  TheMovieExperience
//
//  Created by guillaume on 25/03/2021.
//

import Foundation

class Properties {
    struct APIProperties : Codable {
        let API_KEY : String
        let API_URL : String
    }

    
    static func parseConfig() -> APIProperties {
        let url = Bundle.main.url(forResource: "Properties", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(APIProperties.self, from: data)
    }

}
